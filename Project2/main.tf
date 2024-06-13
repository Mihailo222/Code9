terraform {

  backend "azurerm" {
    resource_group_name = "Code9-12"
    storage_account_name = "stacctfcode912"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "3.104.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
  subscription_id = "8cc22353-a906-4a10-80f7-2f15e3792a10"
}

#10 kontejnera na storrage acc-u
resource "azurerm_storage_container" "code912container" {
  count=10
  name                  = "container${count.index}"
  storage_account_name  = "stacctfcode912"
  container_access_type = "private"
}
#Napraviti 2 vnet-a – prvi sa opsegom 10.1.0.0/24 drugi 10.2.0.0/24
#Napraviti subnet u prvom sa opsegom 10.1.0.0/26, subnet u drugom sa opsegom 10.2.0.0/26

#NSG??

resource "azurerm_virtual_network" "code9-12-vnet1" {
  name                = "code912vnet1"
  location            = "westeurope"
  resource_group_name = "Code9-12"
  address_space       = ["10.1.0.0/24"]

}

resource "azurerm_subnet" "code912-subnet1vnet1" {
  name                 = "vnet1subnet1"
  resource_group_name  = "Code9-12"
  virtual_network_name = azurerm_virtual_network.code9-12-vnet1.name
  address_prefixes     = ["10.1.0.0/26"]


}

resource "azurerm_virtual_network" "code9-12-vnet2" {
  name                = "code912vnet2"
  location            = "westeurope"
  resource_group_name = "Code9-12"
  address_space       = ["10.2.0.0/24"]

}

resource "azurerm_subnet" "code912-subnet1vnet2" {
  name                 = "vnet2subnet1"
  resource_group_name  = "Code9-12"
  virtual_network_name = azurerm_virtual_network.code9-12-vnet2.name
  address_prefixes     = ["10.2.0.0/26"]


}


#Napraviti peering između 2 vneta
resource "azurerm_virtual_network_peering" "code9-12-vnet-peering1" {
  name                      = "peervnet1tovnet2"
  resource_group_name       = "Code9-12"
  virtual_network_name      = azurerm_virtual_network.code9-12-vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.code9-12-vnet2.id
}

resource "azurerm_virtual_network_peering" "code9-12-vnet-peering2" {
  name                      = "peervnet2tovnet1"
  resource_group_name       = "Code9-12"
  virtual_network_name      = azurerm_virtual_network.code9-12-vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.code9-12-vnet1.id
}

#Napraviti Network Security Grupu (NSG) koja će blokirati saobraćaj sa poreklom iz 10.2.0.0/26
resource "azurerm_network_security_group" "vode9-12-nsg1" {
  name                = "blockTrafficFromVnet2Subnet1"
  location            = "westeurope"
  resource_group_name = "Code9-12"

  security_rule {
    name                       = "blockTrafficFromVnet2Subnet1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.2.0.0/26"
    destination_address_prefix = "*"
  }
}


#Napraviti asocijaciju između NSG i prvog subneta (10.1.0.0/26)

resource "azurerm_subnet_network_security_group_association" "code9-12-assoc" {
  subnet_id                 = azurerm_subnet.code912-subnet1vnet1.id
  network_security_group_id = azurerm_network_security_group.vode9-12-nsg1.id
}
