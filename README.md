# POC Ansible

## Requirements

- Docker
- Docker Compose

## Setup

```bash
> ./ssh.sh # generate ssh keys
> docker-compose up -d --build
```

## Run

```bash
> docker exec -it poc-ansible-executor-1 bash
> ansible-playbook update.yml
```
## Ara

[ARA Records Ansible (Ara)](https://github.com/ansible-community/ara) and makes it easier to understand and troubleshoot.

Local setup is available after `docker-compose` setup - [locally](http://localhost:8000).

## Cleanup

```bash
> docker-compose down
```
