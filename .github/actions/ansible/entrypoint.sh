#!/bin/sh

echo "$CODE" | wc -c > ~/count.txt
echo "$CODE" > ~/.vault_pass.txt
mkdir ~/.ssh
ansible-vault view --vault-password-file=~/.vault_pass.txt ansible/ssh_key.txt.secret > ~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa

ansible-playbook --vault-password-file ~/.vault_pass.txt -i ansible/hosts ansible/presetup.yml
