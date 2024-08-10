data "azurerm_virtual_machine" "example_vm" {
  name = "example-machine"
  resource_group_name = data.azurerm_resource_group.ARG.name
}
data "azurerm_resource_group" "ARG" {
  name= "jayant_RG_Tf_Lab"
  
}
data "azurerm_log_analytics_workspace" "law"{
   name = "ayan-law-01"
   resource_group_name = data.azurerm_resource_group.ARG.name

}
resource "azurerm_monitor_data_collection_rule" "example" {
  name                        = "example-rule"
  resource_group_name         = data.azurerm_resource_group.ARG.name
  location                    = "Central India"
#   data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.example.id

  destinations {
    log_analytics {
      workspace_resource_id = data.azurerm_log_analytics_workspace.law.id
      name                  = "example-destination-log"
    }
  }

  data_flow {
    streams      = [ "Microsoft-Perf"]
    destinations = ["example-destination-log"]
  }


  data_sources {

    
    performance_counter {
      streams                       = ["Microsoft-Perf", "Microsoft-InsightsMetrics"]
      sampling_frequency_in_seconds = 60
    
      counter_specifiers            = ["Processor(*)\\% Processor Time"]
      name                          = "example-datasource-perfcounter"
    }
  }  
}
resource "azurerm_monitor_data_collection_rule_association" "dcra1" {
name                    = "dcra"
target_resource_id      = data.azurerm_virtual_machine.example_vm.id
data_collection_rule_id = azurerm_monitor_data_collection_rule.example.id
}