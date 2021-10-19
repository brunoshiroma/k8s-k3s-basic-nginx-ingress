variable "tenancy_ocid" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "ssh_public_key" {
}

variable "ssh_private_key_file" {
}

variable "compartment_ocid" { #if you uses the root, ocid is the same of tenancy_ocid
}

variable "region" {
}

variable "vm_image"{
    
}

variable "private_key_password" {
  
}

variable "subnet_id" {
  
}

variable "ad_region_mapping" {
  type = map(string)

  default = {
    us-phoenix-1 = 2
    us-ashburn-1 = 3
    us-seattle-1 = 2
    sa-saopaulo-1 = 1
  }
}