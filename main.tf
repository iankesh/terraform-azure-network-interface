data "azurerm_resource_group" "azure_rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "azure_vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.azure_rg.name
}

data "azurerm_subnet" "azure_subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.azure_vnet.name
  resource_group_name  = data.azurerm_resource_group.azure_rg.name
}

data "azurerm_public_ip" "azure_public_ip" {
  name                 = var.public_ip_name
  resource_group_name  = data.azurerm_resource_group.azure_rg.name
}

resource "azurerm_network_interface" "az_network_interface" {
  name                = var.name
  location            = data.azurerm_resource_group.azure_rg.location
  resource_group_name = data.azurerm_resource_group.azure_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.azure_subnet.id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = var.public_ip_id
  }
  tags = {
    Region      = data.azurerm_resource_group.azure_rg.location
    Team        = var.team_tag
    Environment = var.env
    Creator     = var.creator
  }
}
