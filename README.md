# aws-arm-simple-setup
Simple setup to provide AWS ARM64 VM

## tfvars

terraform.tfvars content: 
```
name = "name-you-will-use"
creator = "you"
```

## commands

```shell
ssh-keygen -t rsa -b 4096 -f ./vms_rsa -N ''
terraform init
terraform apply
ssh centos@11.22.33.44 -i ./vms_rsa
```
