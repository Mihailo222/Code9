
variable "server_name" {
    default = "code912dbserver"  
}
variable "resource_group" {
  default = "Code9-12"
}

variable "location" {
  default = "westeurope"
}

variable "sql_version" {
  default=12
}

variable "admin_login" {
  default="sqladmin"
}
variable "administrator_login_password" {
  default="veryStrongPass123"  
}

variable "database" {
  default="code912db"
}

variable "sku_name" {
  default="Basic"
}