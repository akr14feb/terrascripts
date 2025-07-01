cd /var/lib/jenkins/workspace/oneClickDeploy
rm -rf /var/lib/jenkins/workspace/oneClickDeploy/compute.tf
rm -rf /var/lib/jenkins/workspace/oneClickDeploy/terraform*
. /var/lib/jenkins/workspace/oneClickDeploy/vars.env
terraform init
terraform plan
terraform apply -auto-approve
