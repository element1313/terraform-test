provider "google" {
  credentials = file(var.authentication_json_file)
  project     = var.project_id
}


resource "google_dns_managed_zone" "dns_zone" {
  for_each = { for zone in var.dns_config : zone.zone_name => zone }


  
  name        = each.value.zone_name
  dns_name    = each.value.dns_name
  description = each.value.description
  visibility  = each.value.visibility
  labels = {
    zone_type = "private_dns_zone"
  }

  private_visibility_config {
    networks {
      network_url = each.value.network_url
    }
  }
}



# resource "google_dns_record_set" "record_set" {
#   for_each = { for zone in var.dns_config : zone.zone_name => zone }


#   name  = each.value.subdomain
#   type  = each.value.record_type
#   ttl   = each.value.ttl
 
#   managed_zone =  google_dns_managed_zone.dns_zone[each.key]                     

#   rrdatas = each.value.rrdatas

#   depends_on = [
#     google_dns_managed_zone.dns_zone

#   ]
# }
