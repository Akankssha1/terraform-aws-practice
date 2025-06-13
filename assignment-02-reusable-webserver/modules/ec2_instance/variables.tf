variable "ami_id" {
  type        = string
  description = "AMI ID to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "subnet_id" {
  type        = string
  description = "Subnet to launch the instance into"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the EC2 instance"
}
