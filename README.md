# 1. Pre-requisites:
- yq installation (https://github.com/mikefarah/yq)
- ansible password location: `~/.ansible.vault.pass`

# 2. Usage

a, installation
```
git clone https://github.com/contactcuong/ansible-decrypt.git
sudo cp ansible-decrypt/ansible-decrypt.sh /usr/local/bin/ansible-decrypt
sudo chmod 0755 /usr/local/bin/ansible-decrypt
```

b, decrypt ALL `*.yml`, `*.yaml`

```
cd /your/ansible/playbook/location
ansible-decrypt
```

c, decrypt specific `*.yml`, `*.yaml`

```
cd /your/ansible/playbook/location
ansible-decrypt your-yml-file.yml
ansible-decrypt your-yaml-file.yaml
```