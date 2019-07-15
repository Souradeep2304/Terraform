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

resource "azurerm_network_security_rule" "rule1" {
  name= "HTTPorHTTPS"
  network_security_group_name ="${azurerm_network_security_group.nsg1.name}"
  direction= "Inbound"   

  access= "Allow"
  priority= 100
  source_address_prefix = "*"
  source_port_range = "*"
  destination_address_prefix= "13.0.0.0/24"
  destination_port_ranges = ["80","443"]
  protocol = "Tcp"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule1a" {
  name= "HTTPorHTTPS"
  network_security_group_name = "${azurerm_network_security_group.nsg4.name}"
  direction= "Inbound"   

  access= "Allow"
  priority= 100
  source_address_prefix = "*"
  source_port_range = "*"
  destination_address_prefix= "16.0.0.0/24"
  destination_port_ranges = ["80","443"]
  protocol = "Tcp"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}

resource "azurerm_network_security_rule" "rule2" {
    name = "DenyCommToDatabase"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "*"
  source_address_prefix = "*"
  destination_address_prefix ="13.0.2.0/24"
  access= "Deny"
  priority= 100
  direction= "Outbound"
   resource_group_name= "${azurerm_resource_group.tera.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg1.name}"


}
resource "azurerm_network_security_rule" "rule2a" {
    name = "DenyCommToDatabase"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "*"
  source_address_prefix = "*"
  destination_address_prefix= "16.0.2.0/24"
  access= "Deny"
  priority= 100
  direction= "Outbound"
   resource_group_name= "${azurerm_resource_group.tera.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg4.name}"


}

resource "azurerm_network_security_rule" "rule3" {
   name = "WEBtoAPI"
          

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["81","445"]
  source_address_prefix = "13.0.0.0/24"
  destination_address_prefix= "13.0.1.0/24"
  access= "Allow"
  priority= 110
  direction= "Outbound"
  
  network_security_group_name = "${azurerm_network_security_group.nsg1.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule3a" {
   name = "WEBtoAPI"
          

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["81","445"]
  source_address_prefix = "16.0.0.0/24"
  destination_address_prefix= "16.0.1.0/24"
  access= "Allow"
  priority= 110
  direction= "Outbound"
  
  network_security_group_name = "${azurerm_network_security_group.nsg4.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}


resource "azurerm_network_security_rule" "rule4" {
   name= "HTTPfromWEB"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["80","443"]
  source_address_prefix = "13.0.0.0/24"
  destination_address_prefix= "13.0.1.0/24"
  access= "Allow"
  priority= 100
  direction= "Inbound"
 
  network_security_group_name ="${azurerm_network_security_group.nsg2.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule4a" {
   name= "HTTPfromWEB"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["80","443"]
  source_address_prefix = "16.0.0.0/24"
  destination_address_prefix= "16.0.1.0/24"
  access= "Allow"
  priority= 100
  direction= "Inbound"
 
  network_security_group_name = "${azurerm_network_security_group.nsg5.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule5" {
   name= "DATABASEtoAPI"
            

  protocol = "Tcp"
  source_port_ranges = ["80","443"]
  destination_port_ranges = ["81","445"]
  source_address_prefix = "13.0.2.0/24"
  destination_address_prefix= "13.0.1.0/24"
  access= "Allow"
  priority= 110
  direction= "Inbound"
  
  network_security_group_name = "${azurerm_network_security_group.nsg2.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule5a" {
   name= "DATABASEtoAPI"
            

  protocol = "Tcp"
  source_port_ranges = ["80","443"]
  destination_port_ranges = ["81","445"]
  source_address_prefix = "16.0.2.0/24"
  destination_address_prefix= "16.0.1.0/24"
  access= "Allow"
  priority= 110
  direction= "Inbound"
  
  network_security_group_name = "${azurerm_network_security_group.nsg5.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule6" {
   name= "FTPin"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "16.0.2.0/24"
  destination_address_prefix= "16.0.1.0/24"
  access= "Allow"
  priority= 120
  direction= "Inbound"
  network_security_group_name = "${azurerm_network_security_group.nsg5.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule6a" {
   name= "FTPin"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "13.0.2.0/24"
  destination_address_prefix= "13.0.1.0/24"
  access= "Allow"
  priority= 120
  direction= "Inbound"
  network_security_group_name = "${azurerm_network_security_group.nsg2.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule7" {
   name= "APItoDATABASE"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "3306"
  source_address_prefix = "16.0.1.0/24"
  destination_address_prefix= "16.0.2.0/24"
  access= "Allow"
  priority= 100
  direction= "Outbound"
  network_security_group_name = "${azurerm_network_security_group.nsg5.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule7a" {
   name= "APItoDATABASE"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "3306"
  source_address_prefix = "13.0.1.0/24"
  destination_address_prefix= "13.0.2.0/24"
  access= "Allow"
  priority= 100
  direction= "Outbound"
  network_security_group_name = "${azurerm_network_security_group.nsg2.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule8" {
   name= "APItoWEB"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["82","446"]
  source_address_prefix = "13.0.2.0/24"
  destination_address_prefix= "13.0.0.0/24"
  access= "Allow"
  priority= 110
  direction= "Outbound"
  network_security_group_name = "${azurerm_network_security_group.nsg2.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule8a" {
   name= "APItoWEB"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["82","446"]
  source_address_prefix = "16.0.2.0/24"
  destination_address_prefix= "16.0.0.0/24"
  access= "Allow"
  priority= 110
  direction= "Outbound"
  network_security_group_name = "${azurerm_network_security_group.nsg5.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule9" {
   name= "FTP"
          

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "21"
  source_address_prefix = "13.0.1.0/24"
  destination_address_prefix= "13.0.2.0/24"
  access= "Allow"
  priority= 120
  direction= "Outbound"
  network_security_group_name = "${azurerm_network_security_group.nsg2.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule9a" {
   name= "FTP"
          

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "21"
  source_address_prefix = "16.0.1.0/24"
  destination_address_prefix= "16.0.2.0/24"
  access= "Allow"
  priority= 120
  direction= "Outbound"
  network_security_group_name = "${azurerm_network_security_group.nsg5.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}


resource "azurerm_network_security_rule" "rule10" {
   name= "InboundFromAPI"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "3306"
  source_address_prefix = "13.0.1.0/24"
  destination_address_prefix= "13.0.2.0/24"
  access= "Allow"
  priority= 100
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg3.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule10a" {
   name= "InboundFromAPI"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "3306"
  source_address_prefix = "16.0.1.0/24"
  destination_address_prefix= "16.0.2.0/24"
  access= "Allow"
  priority= 100
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg6.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule11" {
   name= "InboundFromWEB"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "*"
  source_address_prefix = "16.0.0.0/24"
  destination_address_prefix= "16.0.2.0/24"
  access= "Deny"
  priority= 110
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg6.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule11a" {
   name= "InboundFromWEB"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "*"
  source_address_prefix = "13.0.0.0/24"
  destination_address_prefix= "13.0.2.0/24"
  access= "Deny"
  priority= 110
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg3.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule12" {
   name= "SSH"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "22"
  source_address_prefix = "16.0.2.0/24"
  destination_address_prefix= "16.0.2.0/24"
  access= "Allow"
  priority= 120
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg6.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule12a" {
   name= "SSH"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "22"
  source_address_prefix = "13.0.2.0/24"
  destination_address_prefix= "13.0.2.0/24"
  access= "Allow"
  priority= 120
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg3.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule13" {
   name= "FTP"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "21"
  source_address_prefix = "13.0.1.0/24"
  destination_address_prefix= "13.0.2.0/24"
  access= "Allow"
  priority= 130
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg3.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule13a" {
   name= "FTP"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "21"
  source_address_prefix = "16.0.1.0/24"
  destination_address_prefix= "16.0.2.0/24"
  access= "Allow"
  priority= 130
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg6.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule14" {
   name= "DATABASEToAPI"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_ranges = ["81","445"]
  source_address_prefix = "16.0.2.0/24"
  destination_address_prefix= "16.0.1.0/24"
  access= "Allow"
  priority= 100
  direction= "Outbound"
  network_security_group_name ="${azurerm_network_security_group.nsg6.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule14a" {
   name= "DATABASEToAPI"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_ranges = ["81","445"]
  source_address_prefix = "13.0.2.0/24"
  destination_address_prefix= "13.0.1.0/24"
  access= "Allow"
  priority= 100
  direction= "Outbound"
  network_security_group_name ="${azurerm_network_security_group.nsg3.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule15" {
   name= "FTPout"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "21"
  source_address_prefix = "16.0.2.0/24"
  destination_address_prefix= "16.0.1.0/24"
  access= "Allow"
  priority= 110
  direction= "Outbound"
  network_security_group_name ="${azurerm_network_security_group.nsg6.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "rule15a" {
   name= "FTPout"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "21"
  source_address_prefix = "13.0.2.0/24"
  destination_address_prefix= "13.0.1.0/24"
  access= "Allow"
  priority= 110
  direction= "Outbound"
  network_security_group_name ="${azurerm_network_security_group.nsg3.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
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