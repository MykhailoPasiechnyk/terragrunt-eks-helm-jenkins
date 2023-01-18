variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
  type        = string
  description = "CIDR block for public subnet 1"
  default     = "10.0.1.0/24"
}

variable "public_subnet2_cidr" {
  type        = string
  description = "CIDR block for public subnet 2"
  default     = "10.0.2.0/24"
}

variable "public_subnet1_az" {
  type        = string
  description = "Availability Zone for public subnet 1"
  default     = "eu-central-1a"
}

variable "public_subnet2_az" {
  type        = string
  description = "Availability Zone for public subnet 2"
  default     = "eu-central-1b"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster."
  default     = "cluster"
}
