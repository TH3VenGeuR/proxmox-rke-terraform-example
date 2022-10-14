variable "user_password" {
  type = string
  default = ""
  sensitive = true
}
variable "sshpublickey" {
  type = string
  default = ""
  description = "A ssh public key, without a passphrase"
}
variable "proxmox_url" {
  type = string 
  default = "https://localhost:8006/api2/json"
  description = "ip address of proxmox server"
}
variable "proxmox_user" {
  type = string
  default = ""
  description = "username that have enough right to connect to proxmox and deploy vms"
}
variable "proxmox_password" {
  type = string
  sensitive = true
  default = ""
  description = "password for the promox user"
}
variable "sshprivatekeypath" {
  type = string
  default = "~/.ssh/id_rsa"
  description = "path to the ssh private key, without passphrase, used to connect to nodes"
}
variable "storagesize" {
  type = string
  default = "50G"
  description = "storage size of the root"
}
variable "storagepath" {
  type = string
  default = ""
  description = "datastore to use"
}
variable "noderam" {
  type = number
  default = 8192
  description = "ram of the vm"
}
variable "nodecore" {
  type = number
  default = 1 
  description = "number of physical core of the vm "
}
variable "nodesocket" {
  type = number
  default = 4
  description = "number of vcpu of the vm"
}
variable "vmtemplate" {
  type = string 
  default = ""
  description = "name of the template to use during clone"
}
variable "pvetargetnodename" {
  type = string 
  default = "pve"
  description = "name of the pve to locate the nodes"
}
