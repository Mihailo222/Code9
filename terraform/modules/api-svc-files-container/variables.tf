variable "storage_account" {
  default="code9fullstackappsa"
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
  default="code9apifiles"
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