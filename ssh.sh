#!/usr/bin/env bash

set -e

rm -rf ./ssh/*

ssh-keygen -t ed25519 -O application=ssh:ansible.test -C "" -N "" -f "./ssh/ssh.ed25519.ansible.test" -a $(seq 3 64 | sort -R | head -n 1)

mv ./ssh/ssh.ed25519.ansible.test ./ssh/ssh.ed25519.ansible.test.prv

cat ./ssh/ssh.ed25519.ansible.test.pub > ./ssh/authorized_keys

cat > ./ssh/config <<EOF
Host app01,app02,app03,app04
  IdentityFile ~/.ssh/ssh.ed25519.ansible.test.prv

Host *
  AddKeysToAgent 1s
  Compression yes
  ConnectionAttempts 2
  ControlMaster no
  ForwardAgent yes
  ForwardX11 no
  GlobalKnownHostsFile /dev/null
  HashKnownHosts yes
  LogLevel ERROR
  PreferredAuthentications publickey,keyboard-interactive
  Protocol 2
  ServerAliveCountMax 5
  ServerAliveInterval 60s
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null

  IdentityFile ~/.ssh/ssh.ed25519.ansible.test.prv
EOF
