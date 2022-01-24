locals {
    tables = flatten([
        for instance in var.bigtables : [
            for table in instance.tables : {
                instance_name = instance.instance_name
                project_id    = instance.project_id
                table_name    = table.table_name
                split_keys    = table.split_keys
                column_family = table.column_family
                roles         = table.roles
            }
        ]
    ])

    table_iam_bindings = flatten([
        for table in local.tables : [
            for role in table.roles : {
                instance_name = table.instance_name
                project_id    = table.project_id
                table_name    = table.table_name
                role          = role.role
                members       = role.members  
            }
        ]
    ])

    instance_iam_bindings = flatten([
        for instance in var.bigtables : [
            for role in instance.roles : {
                instance_name = instance.instance_name
                project_id    = instance.project_id
                role          = role.role
                members       = role.members
            }
        ]
    ])
}
