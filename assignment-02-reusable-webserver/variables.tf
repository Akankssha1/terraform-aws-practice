variable "aws_region" {
  description = "The AWS region"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "web_server_ami" {
  description = "AMI ID for the web server"
  default     = "ami-0c768662cc797cd75" # Example Amazon Linux 2 for ap-south-1, update as needed
}

