variable "bigtables" {
    type = list(any)
    default = []
    description = "Big Table"
}


# Example

# bigtables = [
#     {
#         instance_name = ""
#         project_id = ""
#         display_name = ""
#         deletion_protection = false
#         labels = {}
#         cluster_id = ""
#         zone = ""
#         num_nodes = 1
#         storage_type = "SSD"
#         kms_key_name = ""
#         profile = {
#             app_profile_id = ""
#             description = ""
#             multi_cluster_routing_use_any = false
#             single_cluster_routing = {
#                 cluster_id = ""
#                 allow_transactional_writes = false
#             }
#             ignore_warnings = false
#             create_timeout = "4m"
#             update_timeout = "4m"
#             delete_timeout = "4m"
#         }
#         roles = [
#             {
#                 role = ""
#                 members = []
#             }
#         ]
#         tables = [
#             {
#                 table_name = ""
#                 split_keys = []
#                 column_family = [{
#                     family = ""
#                 }]
#                 roles = [
#                     {
#                         role = ""
#                         members = []
#                     }
#                 ]
#                 policy = [{
#                     column_family = ""
#                     mode = ""
#                     max_age = {
#                         days = 1
#                         duration = ""
#                     }
#                     max_version = 10
#                 }]
#             }
#         ]
#     }
# ]
