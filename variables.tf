variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
  default     = "shokhrukh-rajabov-terraform"
}
variable "authentication_json_file" {
  description = "JSON file used to describe your account credentials"
  type        = string
  default     = "keys.json"
}

# should be able to create multiple zones
# should be able to create multiple record sets
# I will use network url to descide which type of zone I am creating 
# use 2 seperate variables for dns zone and record set        (zone)  (record_set)


variable "dns_config" {   
  type = list(any)
  default = [{
    zone_name = "shokh-r-zone"
    visibility = "private"
    description = "Example DNS zone"
    record_description = "example record description"
    dns_name   = "shokh-r-choreograph.com."  
    subdomain   = "example-subdomain"
    network_url = "projects/shokhrukh-rajabov-terraform/global/networks/custom-vpc-tf"
    record_type = "A"
    ttl         = 300
    rrdatas     = "8.8.8.8"
  }]
}
