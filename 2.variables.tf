# Define the AMI ID
variable "ami_id" {
  description = "The AMI ID for EC2 instances"
  type        = string
  default     = "ami-0d51f1cc38a8f1987"
}

# Define the instance type
variable "instance_type" {
  description = "The instance type for EC2 instances"
  type        = string
  default     = "t2.micro"
}

# Define the desired capacity for the auto scaling group
variable "desired_capacity" {
  description = "The desired number of EC2 instances"
  type        = number
  default     = 2
}

# Define minimum and maximum size for the auto scaling group
variable "min_size" {
  type        = number
  default     = 1
}

variable "max_size" {
  type        = number
  default     = 4
}

# Data for Default VPC and Subnets
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}