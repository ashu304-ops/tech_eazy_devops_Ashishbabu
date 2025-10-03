resource "azurerm_role_assignment" "vm_blob_reader" {
  for_each             = toset(azurerm_linux_virtual_machine.vm[*].identity[0].principal_id)
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = each.value
}
