variable "storage_account" {
  default="code9tfacc"
}
variable "resource_group" {
  default = "Code9-12"
}
variable "location" {
  default="westeurope"
}
variable "acc_replication_type" {
  default = "LRS"
}

variable "container_name" {
  default="code912tfstate"
}

variable "acc_tier" {
  default = "Standard"
}

variable "access_tier" {
  default="Hot"
}

variable "container_access_type" {
  default = "private"
}