# Terraform + Oracle Cloud
[Oracle cloud](https://cloud.oracle.com/) gives free tier, with vm "forever free"   
This terraform, creates a free tier instance, and configure the k3s to run the k8s ymls

## Links
Doc of the terraform provider for Oracle cloud    
https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_instance  
Explain how to setup the api key, get ocid required  
https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm   
Examples of usage   
https://github.com/terraform-providers/terraform-provider-oci/blob/master/examples/always_free/main.tf

### using the terraform example
With terraform installed and the oracle cloud account configured, you will need the following env var:
```bash
TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..XXXX
TF_VAR_compartment_ocid=ocid1.tenancy.oc1..XXXX # the same of tenancy_ocid if using the root
TF_VAR_user_ocid=ocid1.user.oc1..YYYY
TF_VAR_fingerprint=AA:BB:XXXX # the fingerprint to the key used for oracle cloud
TF_VAR_private_key_path=FILE.pem # key you create for the oracle cloud api
TF_VAR_vm_image=ocid1.image.oc1.sa-saopaulo-1.ZZZZ
TF_VAR_region=sa-saopaulo-1
TF_VAR_subnet_id=ocid1.subnet.oc1.sa-saopaulo-1.NNNN
TF_VAR_ssh_private_key_file=KEY_FILE # a path to any key without pass, to use to access the instance via ssh
TF_VAR_ssh_public_key=ssh-ed25519 XXXXX dummy@email.com # the pub pair of the private_key_file to use to access the instance, here are the content of file
```

And execute the basic terraform commands:
```bash
# on the dir terraform, with the *.tf files
terraform init
terraform plan
terraform apply
```