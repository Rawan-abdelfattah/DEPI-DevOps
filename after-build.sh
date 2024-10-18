#!/bin/bash

cd ansible

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.aws_ec2.yml docker-setup.yml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.aws_ec2.yml deploy.yml
