terraform {
  backend "s3" {
    bucket = "terraform-remote-state"
    key    = "homelab"
    region = "homenet"
    endpoints = {
      s3 = "http://s3.homelab.net:7480"
    }
    insecure = true
    # access_key = ""
    # secret_key = ""
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}
