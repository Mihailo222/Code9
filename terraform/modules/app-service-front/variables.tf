variable "front_app_svc_plan" {
     type=string 
     default = "code9reactwebapp"
}

variable  "location" {
    type=string
    default="westeurope"
}

variable "resource_group" {
    type=string
    default="Code9-12" 
}

variable "sku_tier" {
    type=string
    default="Basic"
}

variable "sku_size" {
    type=string
    default="B1"
}

variable "front_app_svc" {
    type=string
    default="code912reactwebapp"
}

variable "tls_version" {
    type=number
    default=1.2
}