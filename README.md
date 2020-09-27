# Terraform Modules
![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)

Terraform modules for everything.

My Custom Terraform Modules [here](https://registry.terraform.io/namespaces/iankesh).

### Terraform Module to create Network Interface Controller in Microsoft Azure
#### Tools Used
- Terraform: Version 0.12.29
- Azurerm provider: Version v2.20.0

#### Parameters to pass
| Parameters | Need | Description
| ------ | ------ | ------ |
source |(Required)|source of this module
name|(Required)|name of the Security Group
resource_group_name|(Required)|name of the Resorce Group
vnet_name|(Reqiured)|The name of the virtual network
subnet_name|(Required)|The name of subnet
private_ip_allocation|(Required)|The allocation method for IP
public_ip_name|(Reqiured)|The name of public Ip
public_ip_id|(Required)|The id of public Ip
env|(Optional)|name of the environment
team_tag|(Optional)|tag a team
creator|(Optional)|tag a creator

#### Usage:
###### Import existing Resource Group
```terraform
provider "azurerm" {
  version = "=2.20.0"
  features {}
}

module "az_network_interface" {
  source                = "iankesh/network-interface/azure"
  name                  = "ankesh-network-interface"
  resource_group_name   = "ankesh-workspace"
  vnet_name             = "ankesh-vnet"
  subnet_name           = "ankesh-subnet"
  private_ip_allocation = "Dynamic"
  public_ip_id          = "/subscriptions/55b07678-705b-45fa-904c-346637b84794/resourceGroups/ankesh-workspace/providers/Microsoft.Network/publicIPAddresses/ankesh-public-ip"
  public_ip_name        = "ankesh-public-ip"
}
```

###### Create new Network Interface Controller using module
```terraform
provider "azurerm" {
  version = "=2.20.0"
  features {}
}

module "az_resource_group" {
  source   = "iankesh/resource-group/azure"
  name     = "ankesh-workspace"
  location = "westeurope"
  team_tag = "DevOps"
  creator  = "ankesh"
}

module "az_virtual_network" {
  source              = "iankesh/virtual-network/azure"
  name                = "ankesh-vnet"
  resource_group_name = module.az_resource_group.az_rg_name
  address_space       = "10.0.2.0/24"
  env                 = "dev"
  team_tag            = "DevOps"
  creator             = "ankesh"
}

module "az_subnet" {
  source              = "iankesh/subnet/azure"
  name                = "ankesh-subnet"
  resource_group_name = module.az_resource_group.az_rg_name
  vnet_name           = module.az_virtual_network.az_vnet_name
  address_prefix      = "10.0.2.0/26"
}

module "az_security_group" {
  source                              = "iankesh/security-group/azure"
  name                                = "ankesh-security-group"
  resource_group_name                 = module.az_resource_group.az_rg_name
  security_rule_name                  = "ankesh-security-rule"
  security_priority                   = "101"
  security_direction                  = "Inbound"
  security_access                     = "Allow"
  security_protocol                   = "Tcp"
  security_source_port                = "*"
  security_destination_port           = ["80", "22", "443"]
  security_source_address_prefix      = "*"
  security_destination_address_prefix = "*"
  env                                 = "dev"
  team_tag                            = "DevOps"
  creator                             = "ankesh"
}

module "az_public_ip" {
  source              = "iankesh/public-ip/azure"
  name                = "ankesh-public-ip"
  resource_group_name = module.az_resource_group.az_rg_name
  allocation          = "Static"
  ip_version          = "IPv4"
  env                 = "dev"
  team_tag            = "DevOps"
  creator             = "ankesh"
}

module "az_network_interface" {
  source                = "iankesh/network-interface/azure"
  name                  = "ankesh-network-interface"
  resource_group_name   = module.az_resource_group.az_rg_name
  vnet_name             = module.az_virtual_network.az_vnet_name
  subnet_name           = module.az_subnet.az_subnet_name
  private_ip_allocation = "Dynamic"
  public_ip_id          = module.az_public_ip.az_public_ip_id
  public_ip_name        = module.az_public_ip.az_public_ip_name
}
```

#### Terraform Execution:
###### To initialize Terraform:
```sh
terraform init
```

###### To execute Terraform Plan:
```sh
terraform plan
```

###### To apply Terraform changes:
```sh
terraform apply
```

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
