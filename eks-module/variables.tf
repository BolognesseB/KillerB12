variable "cluster_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "ec2_types" {
  type = list(string)
}

variable "nodegroup_desired" {
  type = number
}

variable "nodegroup_max" {
  type = number
}
variable "nodegroup_min" {
  type = number
}
