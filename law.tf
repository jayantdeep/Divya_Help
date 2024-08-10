# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West Europe"
# }
data "azurerm_resource_group" "RG" {
  name= "jayant_RG_Tf_Lab"
  
}
resource "azurerm_log_analytics_workspace" "example" {
  name                = "ayan-law-01"
  location            = "Central India"
  resource_group_name = data.azurerm_resource_group.RG.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}