# ansible-poc
Ansible playbook to setup a POC platform of Caliopen using docker stack

#For deployment, please modify the hosts file and add your values for:

- ansible_ssh_host=
- ansible_ssh_private_key_file= (Only if your authentification on Gandi's server is with SSH key. If not, you can remove the ansible_ssh_private_key_file method)


# You can now deploy the docker's stack on gandi IAAS:

ansible-playbook -i hosts -K playbook.yml
