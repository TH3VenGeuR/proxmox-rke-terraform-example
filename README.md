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


