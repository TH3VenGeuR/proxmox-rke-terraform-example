## Goal : 
This project aims to discover terraform. With this code you will install a 3 nodes kubernetes cluster based on rke. with following parameters:
- Per nodes : 8GB of RAM, 4 CPU, 50GB of storage
- Fixed IP adresses in 192.168.1.0/24
- Kubernetes version 1.24

As prerequisites, you must have a proxmox hypervisor, a vm template within the hypervisor with cloud-init 

See References below for more informations and customizations.

## How to use: 
 1. Uncomment lines in terraform.tf and replace with real values (see example and description in variable.tf):
 
**Because provider block does not support variables, be sure tu insert real values in terraform.tf**
```bash
#pm_api_url = var.proxmox_url
#pm_password = var.proxmox_password
#pm_user = var.proxmox_user
```
 2. then install providers with :
`terraform init`
 3. create a tfvars file and add define require variables :
```bash
cat  << EOF > terraform.tfvars
user_password = "thepassword"
sshpublickey = "ssh-rsa mykey example@example.com"
proxmox_user = "root"
proxmox_password = "rootpassword"
proxmox_url = "https://localhost:8006/api2/json"
sshprivatekeypath = "~/.ssh/id_rsa"
vmtemplate = "template" 
storagepath = "datastore"
EOF
```
 4. Plan and apply:
`terraform plan`
`terraform apply`

## References and resources: 
- https://www.proxmox.com/en/
- https://docs.powerhost.io/?docs=proxmox-cloud-init-template-guide
- https://learn.hashicorp.com/tutorials/terraform/install-cli
- https://www.terraform.io/cli/commands
- https://github.com/Telmate/terraform-provider-proxmox
- https://github.com/rancher/terraform-provider-rke/
