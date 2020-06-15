provider "azurerm" {
  version = "=2.0.0"
  features {}


resource "azurerm_resource_group" "tera" {
  name="TerraformRG"
  location="East US"
}

resource "azurerm_network_security_group" "nsg1" {
  name                = "W1"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}

resource "azurerm_network_security_group" "nsg2" {
  name                = "A1"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_group" "nsg3" {
  name                = "D1"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}

resource "azurerm_network_security_group" "nsg4" {
  name                = "W2"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_group" "nsg5" {
  name                = "A2"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_group" "nsg6" {
  name                = "D2"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "V1"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
  address_space       = ["13.0.0.0/16"]


  subnet {
    name           = "S1"
    address_prefix = "13.0.0.0/24"
    security_group="${azurerm_network_security_group.nsg1.id}"
  }
   subnet {
    name           = "S2"
    address_prefix = "13.0.1.0/24"
    security_group="${azurerm_network_security_group.nsg2.id}"
  }
   subnet {
    name           = "S3"
    address_prefix = "13.0.2.0/24"
    security_group="${azurerm_network_security_group.nsg3.id}"
  }
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "V2"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
  address_space       = ["16.0.0.0/16"]


  subnet {
    name           = "S1"
    address_prefix = "16.0.0.0/24"
    security_group="${azurerm_network_security_group.nsg4.id}"
  }
   subnet {
    name           = "S2"
    address_prefix = "16.0.1.0/24"
    security_group="${azurerm_network_security_group.nsg5.id}"
  }
   subnet {
    name           = "S3"
    address_prefix = "16.0.2.0/24"
    security_group="${azurerm_network_security_group.nsg6.id}"
  }
}

resource "azurerm_virtual_network_peering" "peer1" {
  name                      = "V1toV2"
  resource_group_name       = "${azurerm_resource_group.tera.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet1.name}"
  remote_virtual_network_id = "${azurerm_virtual_network.vnet2.id}"
}

resource "azurerm_virtual_network_peering" "peer2" {
  name                      = "V2toV1"
  resource_group_name       = "${azurerm_resource_group.tera.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet2.name}"
  remote_virtual_network_id = "${azurerm_virtual_network.vnet1.id}"
}