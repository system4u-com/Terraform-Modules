resource "azurerm_automation_account" "automation_accounts" {
  for_each = var.automation_accounts
  
}