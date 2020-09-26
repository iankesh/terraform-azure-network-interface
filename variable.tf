variable "resource_group_name" {
  description = "(Required) The name of an existing resource group to be imported."
  type        = string
}

variable "name" {
  description = "(Required) The name of the Security Group"
  default     = "cloud-network-interface"
}

variable "vnet_name" {
  description = "(Required) The name of the virtual network"
  default     = "cloud-vnet"
}

variable "subnet_name" {
  description = "(Required) The name of subnet"
  default     = "cloud-subnet"
}

variable "private_ip_allocation" {
  description = "(Required) The allocation method for IP. Possible values are Dynamic and Static"
  default     = "Dynamic"
}

variable "public_ip_name" {
  description = "(Required) The name of public Ip"
  default     = "ankesh-public-ip"
}

variable "public_ip_id" {
  description = "(Required) The id of public Ip"
  default     = "/subscriptions/55b07678-705b-45fa-904c-346637b84794/resourceGroups/ankesh-workspace/providers/Microsoft.Network/publicIPAddresses/ankesh-public-ip"
}

variable "env" {
  description = "(Optional) name of the resource group"
  default     = "dev"
}

variable "team_tag" {
  description = "(Optional) tag a team"
  default     = "DevOps"
}

variable "creator" {
  description = "(Optional) tag a creator"
  default     = "iankesh"
}

