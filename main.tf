resource "proxmox_vm_qemu" "server" {
  name        = "kube0${count.index + 1}"
  desc        = "tf description"
  target_node = var.pvetargetnodename 
  count       = 3
  clone       = var.vmtemplate 
  
  # The destination resource pool for the new VM
  pool = "home"
  vmid      = "10${count.index + 1}"
  cores     = var.nodecore
  sockets   = var.nodesocket
  memory    = var.noderam
  os_type   = "cloud-init"
  agent     = 1
  ipconfig0 = "ip=192.168.1.20${count.index + 1}/24,gw=192.168.1.254"
  sshkeys = <<EOF
var.sshpublickey
EOF
  disk {
    slot    = 0
    type    = "scsi"
    size    = var.storagesize
    storage = var.storagepath
    discard = "on"
  }

  network {
    model   = "virtio"
    bridge  = "vmbr0"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get remove docker docker-engine docker.io containerd runc",
      "sudo apt-get update -y && sudo apt-get install ca-certificates curl gnupg lsb-release -y",
      "sudo mkdir -p /etc/apt/keyrings",
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update -y",
      "sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y",
      "sudo usermod -a -G docker user",
    ]
    connection {
      type     = "ssh"
      user     = "user"
      password = var.user_password
      host     = self.ssh_host 
    }
  }
}
resource rke_cluster "cluster" {
  enable_cri_dockerd = true
  nodes {
    address = "192.168.1.201"
    internal_address = "192.168.1.201"
    user    = "user"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = file(var.sshprivatekeypath)
  }
  nodes {
    address = "192.168.1.202"
    internal_address = "192.168.1.202"
    user    = "user"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = file(var.sshprivatekeypath)
  }
  nodes {
    address = "192.168.1.203"
    internal_address = "192.168.1.203"
    user    = "user"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = file(var.sshprivatekeypath)
  }
  depends_on = [
    proxmox_vm_qemu.server
  ]
}
