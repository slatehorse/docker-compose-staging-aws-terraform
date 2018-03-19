resource "aws_security_group" "docker_compose_host_sg" {
  vpc_id = "${module.vpc.vpc_id}"
  name = "${var.project_name}-docker-compose-host"

  # Allow SSH from internal hosts, public & private
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${concat(var.public_subnets, var.private_subnets)}"]
  }

  # Allow forwarded HTTP traffic from ALB listener
  ingress {
    from_port = "${var.docker_compose_http_port}"
    to_port = "${var.docker_compose_http_port}"
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnets}"]
  }

  # Allow forwarded decrypted HTTPS traffic from ALB listener
  ingress {
    from_port = "${var.docker_compose_decrypted_https_port}"
    to_port = "${var.docker_compose_decrypted_https_port}"
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnets}"]
  }

  # Allow all outbound traffic
  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.common_tags}"
}

resource "aws_instance" "docker_compose_host" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.docker_compose_instance_type}"

  # TODO: AZ
  # TODO: key name
  # TODO: monitoring
  vpc_security_group_ids = ["${aws_security_group.docker_compose_host_sg.id}"]
  # TODO: custom EBS size?
  subnet_id = "${module.vpc.private_subnets[0]}"

  monitoring = true

  # Add the Name tag for ease on the web console
  tags = "${merge(map("Name", "${var.project_name}-docker-compose"), "${var.common_tags}")}"
  volume_tags = "${merge(map("Name", "${var.project_name}-docker-compose"), "${var.common_tags}")}"

  user_data = <<EOF
#!/bin/bash
${join("\n", formatlist("echo '%s' > /home/ubuntu/.ssh/authorized_keys", values(var.bastion_host_ssh_public_keys)))}
chown ubuntu: /home/ubuntu/.ssh/authorized_keys
chmod 0600 /home/ubuntu/.ssh/authorized_keys
EOF
}