terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
    rke = {
      source  = "rancher/rke"
      version = "1.3.3"
    }
  }
}

# variables in provider does not work
# replace them with correct values before execution 
provider "proxmox" {
    #pm_tls_insecure = true
    #pm_api_url = var.proxmox_url
    #pm_password = var.proxmox_password
    #pm_user = var.proxmox_user
}
provider "rke" {
  log_file = "rke_debug.log"
}
