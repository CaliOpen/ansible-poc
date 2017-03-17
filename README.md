# caliopen-iaas-poc
Poc for docker deployment on Iaas 

his is a POC to deploy caliopen on a docker stack.

#For deployment, please modify the hosts file and add your values for:

- ansible_ssh_host=
- ansible_ssh_private_key_file= (Only if your authentification on Gandi's server is with SSH key. If not, you can remove the ansible_ssh_private_key_file method)


#You can now run the docker's stack on gandi IAAS:

sudo ansible-playbook -i hosts -K playbook.yml
~                                              
