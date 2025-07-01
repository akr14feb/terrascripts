cd /var/lib/jenkins/workspace/oneClickDeploy
rm -rf /var/lib/jenkins/workspace/oneClickDeploy/compute.tf
terraform init
terraform plan
terraform apply -auto-approve
