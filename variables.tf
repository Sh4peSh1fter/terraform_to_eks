variable "region" {
  description = "default_region"
  default     = "us-east-1"
}

variable "default_tag" {
  description = "default_tag"
  default     = "sean's_stuff"
}

variable "vpc_cidr" {
  description = "The CIDR Block for the SiteSeer VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "subnet CIDR blocks"
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "ami_type" {
  description = ""
  default     = "t3.micro"
}
