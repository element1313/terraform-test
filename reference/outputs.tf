output "bigtable_instances" {
  description = "Big Table Instance name"
  value       = [for db in google_bigtable_instance.bigtable-instance : db.name]
}

output "bigtable_tables" {
  description = "Table Names"
  value       = [for table in google_bigtable_table.table : table.name]
}
