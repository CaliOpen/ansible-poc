# ansible-poc


Ansible playbook to setup a POC platform of Caliopen using docker stack.
Mostly tested using a debian 8 VM on Gandi Iaas platform.

## requirements

You need decent version of [Ansible][1] on the host machine

[1]: http://docs.ansible.com/ansible/intro_installation.html#installing-the-control-machine

## Deployment

For deployment on Gandi's server, please modify the hosts file and add your values for:

- ansible_ssh_host=
- ansible_ssh_private_key_file= (Only if your authentification on Gandi's server is with SSH key. If not, you can remove the ansible_ssh_private_key_file method)

### To deploy using HTTPS only

If you have a TLS certificate and the related private key, you can set `use_https` variable to true in the hosts file
and place the related crt and key files inside roles/caliopen/file directory using file name: caliopen.crt and caliopen.key


You can now deploy the docker's stack on a machine

```
ansible-playbook -i hosts -K playbook.yml
```

This will deploy Caliopen in the release defined in [roles/caliopen/vars/main.yaml](roles/caliopen/vars/main.yaml).

You can overide the version like this:

```
ansible-playbook -i hosts -K playbook.yml --extra-vars "caliopen_version=HEAD"
```

_By default vagrant will be provisioned with Caliopen HEAD revision_

## Development

For deployment on local vagrant machine, use the following command:

```
vagrant up
```

You can now access your caliopen instance with your web browser on localhost:8080


## Load demo fixtures data

```
ansible-playbook -i hosts -K playbook-load-data.yml
```

It will create a dev user with 123456 as password and load some messages
