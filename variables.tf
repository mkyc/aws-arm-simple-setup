variable "name" {
  description = "prefix for all resources"
  type        = string
}

variable "rsa_pub_path" {
  description = "where is local public certificate located"
  type        = string
  default     = "vms_rsa.pub"
}

variable "region" {
  description = "Region to launch in"
  type        = string
  default     = "eu-central-1"
}

variable "ami" {
  description = "AMI to use for VM"
  type        = string
  default     = "ami-0a305a7534a53874c"
  //that is value for eu-central-1 taken from https://wiki.centos.org/Cloud/AWS validated with `aws ec2 describe-images --image-ids ami-0a305a7534a53874c`
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "a1.xlarge"
}

variable "subnet_cidr" {
  description = "subnet CIDR block"
  type        = string
  default     = "10.0.0.0/24"
}

variable "vpc_cidr" {
  description = "vpc CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "root_volume_size" {
  description = "The size of the root volume in gibibytes (GiB)"
  type        = number
  default     = 64
}

variable "creator" {
  description = "creator tag value"
  type        = string
}
