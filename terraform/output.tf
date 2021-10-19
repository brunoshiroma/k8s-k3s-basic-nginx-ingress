output "instance-ip" {
  description = "public ip"
  value       = oci_core_instance.free_instance0.public_ip

}

output "instance-id" {
  description = "id of the instance"
  value       = oci_core_instance.free_instance0.id
}