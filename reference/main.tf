resource "google_bigtable_instance" "bigtable-instance" {
    for_each         = { for instance in var.bigtables : instance.instance_name => instance }
    name             = each.value.instance_name
    project          = each.value.project_id 
    cluster {
        cluster_id   = each.value.cluster_id
        num_nodes    = each.value.num_nodes
        storage_type = each.value.storage_type
        zone         = each.value.zone
        kms_key_name = contains(keys(each.value), "kms_key_name") ? each.value.kms_key_name : null
    }
    deletion_protection = each.value.deletion_protection
    labels = each.value.labels
}

resource "google_bigtable_app_profile" "app_profile" {
    for_each       = { for instance in var.bigtables : instance.instance_name => instance }
    instance       = each.value.instance_name
    app_profile_id = each.value.profile.app_profile_id
    description    = each.value.profile.description
    project        = each.value.project_id

    dynamic "single_cluster_routing" {
        for_each       = contains(keys(each.value.profile), "single_cluster_routing") ? [each.value.profile.single_cluster_routing] : []
        content {
            cluster_id                 = single_cluster_routing.value["cluster_id"]
            allow_transactional_writes = lookup(single_cluster_routing.value, "allow_transactional_writes", null)
        }
    }

    multi_cluster_routing_use_any = lookup(each.value.profile, "multi_cluster_routing_use_any", null)

    ignore_warnings = lookup(each.value.profile, "ignore_warnings", null)

    depends_on = [
        google_bigtable_instance.bigtable-instance
    ]
}

resource "google_bigtable_instance_iam_binding" "instance_binding" {
    for_each  = { for binding in local.instance_iam_bindings : join("_", [binding.role, binding.instance_name]) => binding }  
    instance  = each.value.instance_name
    role      = each.value.role
    members   = each.value.members
    project   = each.value.project_id

    depends_on = [
        google_bigtable_instance.bigtable-instance
    ]
}

resource "google_bigtable_table" "table" {
    for_each      = { for table in local.tables : join("_", [table.table_name, table.instance_name]) => table }
    name          = each.value.table_name
    instance_name = each.value.instance_name
    split_keys    = each.value.split_keys
    project       = each.value.project_id

    depends_on = [
        google_bigtable_instance.bigtable-instance
    ]
}

resource "google_bigtable_table_iam_binding" "table_binding" {

    for_each  = { for binding in local.table_iam_bindings : join("_", [binding.role, binding.table_name, binding.instance_name]) => binding }  
    instance  = each.value.instance_name
    role      = each.value.role
    members   = each.value.members
    table     = each.value.table_name
    project   = each.value.project_id 

    depends_on = [
        google_bigtable_table.table
    ]
}
