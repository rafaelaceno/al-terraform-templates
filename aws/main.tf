// Data sources
data "aws_region" "current" {}

// Create a security group policy and setup rules for the IDS appliance
resource "aws_security_group" "ids_sg" {
  name = "Alert Logic IDS Security Group"

  tags {
    Name = "Alert Logic IDS Security Group"
  }

  vpc_id = "${var.vpc_id}"

  // web app ids ingress rules (uncomment to apply rules)
  # ingress {
  #   protocol    = "tcp"
  #   cidr_blocks = ["204.110.218.96/27"]
  #   from_port   = 4849
  #   to_port     = 4849
  # }


  # ingress {
  #   protocol    = "tcp"
  #   cidr_blocks = ["204.110.219.96/27"]
  #   from_port   = 4849
  #   to_port     = 4849
  # }


  # ingress {
  #   protocol    = "tcp"
  #   cidr_blocks = ["208.71.209.32/27"]
  #   from_port   = 4849
  #   to_port     = 4849
  # }


  // cloudwatch egress rules (uncomment to apply rules)
  # egress {
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  #   from_port   = 443
  #   to_port     = 443
  # }
  # egress {
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  #   from_port   = 80
  #   to_port     = 80
  # }

  // ids required rules
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["${var.monitoring_cidr}"]
    from_port   = 7777
    to_port     = 7777
  }
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["${var.monitoring_cidr}"]
    from_port   = 443
    to_port     = 443
  }
  egress {
    protocol    = "tcp"
    cidr_blocks = ["204.110.218.96/27"]
    from_port   = 443
    to_port     = 443
  }
  egress {
    protocol    = "tcp"
    cidr_blocks = ["204.110.219.96/27"]
    from_port   = 443
    to_port     = 443
  }
  egress {
    protocol    = "tcp"
    cidr_blocks = ["208.71.209.32/27"]
    from_port   = 443
    to_port     = 443
  }
  egress {
    protocol    = "tcp"
    cidr_blocks = ["185.54.124.0/24"]
    from_port   = 443
    to_port     = 443
  }
  egress {
    protocol    = "tcp"
    cidr_blocks = ["204.110.218.96/27"]
    from_port   = 4138
    to_port     = 4138
  }
  egress {
    protocol    = "tcp"
    cidr_blocks = ["204.110.219.96/27"]
    from_port   = 4138
    to_port     = 4138
  }
  egress {
    protocol    = "tcp"
    cidr_blocks = ["208.71.209.32/27"]
    from_port   = 4138
    to_port     = 4138
  }
  egress {
    protocol    = "tcp"
    cidr_blocks = ["185.54.124.0/24"]
    from_port   = 4138
    to_port     = 4138
  }
  egress {
    protocol    = "udp"
    cidr_blocks = ["8.8.8.8/32"]
    from_port   = 53
    to_port     = 53
  }
  egress {
    protocol    = "udp"
    cidr_blocks = ["8.8.4.4/32"]
    from_port   = 53
    to_port     = 53
  }
  egress {
    protocol    = "tcp"
    cidr_blocks = ["8.8.8.8/32"]
    from_port   = 53
    to_port     = 53
  }
  egress {
    protocol    = "tcp"
    cidr_blocks = ["8.8.4.4/32"]
    from_port   = 53
    to_port     = 53
  }
}

// CloudWatch IAM permission for the IDS instance
resource "aws_iam_policy" "ids_cw_policy" {
  name = "Alert_Logic_IDS_CloudWatch_Policy"

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Sid": "1",
       "Action": [
         "cloudwatch:PutMetricData"
      ],
      "Effect": "Allow",
      "Resource": "*"
     }
   ]
}
EOF
}

resource "aws_iam_role" "ids_cw_role" {
  name = "Alert_Logic_IDS_CloudWatch_Role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ids_cw_role_policy_attachment" {
  role       = "${aws_iam_role.ids_cw_role.name}"
  policy_arn = "${aws_iam_policy.ids_cw_policy.arn}"
}

resource "aws_iam_instance_profile" "ids_instance_profile" {
  name = "Alert_Logic_IDS_Instance_Profile"
  role = "${aws_iam_role.ids_cw_role.name}"
}

// Launch IDS instance from a shared AMI
resource "aws_instance" "ids_instance" {
  depends_on             = ["aws_security_group.ids_sg"]
  count                  = "${var.ids_count}"
  ami                    = "${lookup(var.aws_amis, data.aws_region.current.name)}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.ids_sg.id}"]
  iam_instance_profile   = "${aws_iam_instance_profile.ids_instance_profile.name}"
  monitoring             = "${var.enable_monitoring}"

  // Increase EBS volume to 100GB
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 100
    volume_type = "gp2"
  }

  lifecycle {
    ignore_changes = ["ebs_block_device"]
  }

  tags {
    Name = "${var.name_tag}"
    env  = "${var.env_tag}"
  }
}

// Allocate a new Elastic IP to be associated with the IDS instance
resource "aws_eip" "ids_eip" {
  depends_on = ["aws_instance.ids_instance"]
  count      = "${var.create_eip == true ? var.ids_count : 0}"
  instance   = "${element(aws_instance.ids_instance.*.id, count.index)}"
  vpc        = true
}
