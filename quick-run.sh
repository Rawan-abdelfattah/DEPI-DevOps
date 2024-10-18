#!/bin/bash

# create key pair for terraform instances
cd terraform/
ssh-keygen -f mykey
cp mykey ~/.ssh
cp mykey.pub ~/.ssh

# apply and create instances
terraform init
terraform apply --auto-approve
terraform output -json > ../terraform_outputs.json
cd ..

# run env setup script
cd ansible
./env_script.sh

# run playbooks for docker setup and deploy
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.aws_ec2.yml before-docker.yml

# then run jenkins for build

# then these commands manually:
# ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.aws_ec2.yml docker-setup.yml
# ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.aws_ec2.yml deploy.yml