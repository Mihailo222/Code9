variable "api_app_svc_plan" {
     type=string 
     default = "code9apisvcplan"
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

variable "api_app_svc" {
    type=string
    default="code912apiappsvc"
}

variable "tls_version" {
    type=number
    default=1.2
}

variable "dot_net_framework_version" {
    type = string
    default="v6.0"
}