provider "oci" {
  region               = var.region
  tenancy_ocid         = var.tenancy_ocid
  user_ocid            = var.user_ocid
  fingerprint          = var.fingerprint
  private_key_path     = var.private_key_path
  private_key_password = var.private_key_password
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = var.ad_region_mapping[var.region]
}

resource "oci_core_instance" "free_instance0" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "freeInstance0"
  shape               = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = var.subnet_id
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "freeinstance0"
  }

  source_details {
    source_type = "image"
    source_id   = var.vm_image
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  provisioner "remote-exec" {
    connection {
      host        = oci_core_instance.free_instance0.public_ip
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_file)
    }

    inline = [
      # config swap 
      "sudo fallocate -l 1G /swapfile",
      "sudo dd if=/dev/zero of=/swapfile bs=1024 count=1048576",
      "sudo chmod 600 /swapfile",
      "sudo mkswap /swapfile",
      "sudo swapon /swapfile",
      "echo \"/swapfile swap swap defaults 0 0\" | sudo tee -a /etc/fstab",
      # update and install the make
      "sudo apt update",
      "sudo apt install -y make",
      #install the k3s
      "curl -sfL https://get.k3s.io | sh -",
      # download and apply the configs of k8s(k3s) with nginx ingress
      "git clone https://github.com/brunoshiroma/k8s-k3s-basic-nginx-ingress.git",
      "cd k8s-k3s-basic-nginx-ingress && sudo make" # without using the env var SERVICE_HOSTNAME the virtualhost is blank, allowing using of the public ip of instance
    ]

  }

}
