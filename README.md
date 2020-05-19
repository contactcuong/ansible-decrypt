# 1. Pre-requisites:
- yq installation (https://github.com/mikefarah/yq)
- ansible password location: `~/.ansible.vault.pass`

# 2. Usage
a. decrypt ALL `*.yml`, `*.yaml`

```
cd /your/ansible/playbook/location
ansible-decrypt
```

b. decrypt specific `*.yml`, `*.yaml`

```
cd /your/ansible/playbook/location
ansible-decrypt your-yml-file.yml
ansible-decrypt your-yaml-file.yaml
```