<h1>Project 1 - Three Tier Web Application Infrastructure Deployment:</h1>

Azure infrastructure contained of:
- one Basic tier (B1 SKU) frontend React app; HTTPS TLS 1.2
- one Basic tier (B1 SKU) backend App Service using .Net v6.0 and HTTPS TLS 1.2
- one Basic tier (Basic SKU) Azure SQL database
- one Standard LRS Storage Account with blob container that receives files through API
- one Standard LRS Storage Account with blob container with Terraform statefile
- one KeyVault for secrets

Requirements:
- use terraform modules
- use terraform variables

<h1>Project 2 - Networking on Azure. Networks, subnets and peering. </h1>

Azure infrastructure contained of:
- storage account that is added manualy. Add 10 containers on it.
- two VNETs with ranges 10.1.0.0/24 and 10.2.0.0/24
- in first VNET add subnet with range 10.1.0.0/26 and in second VNET add subnet with range 10.2.0.0/26
- Make VNET peering
- Make network security group that bloks a network packets from 10.2.0.0/26 and associate it with first subnet

Requirements:
- use count function for creating 10 containers
