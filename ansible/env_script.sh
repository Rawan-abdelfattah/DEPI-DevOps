export ANSIBLE_INVENTORY=$(pwd)/inventory.aws_ec2.yml

export ANSIBLE_PRIVATE_KEY_FILE=$(pwd)/../terraform/mykey

echo ANSIBLE_PRIVATE_KEY_FILE=$ANSIBLE_PRIVATE_KEY_FILE
echo ANSIBLE_INVENTORY=$ANSIBLE_INVENTORY

ansible-inventory --list > inventory.json