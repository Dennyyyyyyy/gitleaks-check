# Instruction for installing the pre-commit script

The script streamlines the process of setting up, removing, tidying, and updating pre-commit hooks within your Git repositories.

By employing pre-commit hooks, it verifies that your commits adhere to specific standards and guards against inadvertent exposure of sensitive information.

## Installation

### ! Please be attentive; Python must be installed on your operating system.

1. Next command download the script using curl and run installation
```sh
curl -o https://raw.githubusercontent.com/Dennyyyyyyy/gitleaks-check/main/pre_commit_check.sh
```

2. 

root@deb12-dev:/home/denis/kbot# curl -fsSL https://raw.githubusercontent.com/Dennyyyyyyy/gitleaks-check/main/pre_commit_check.sh | sh -s create_config
Your operation system is: Linux
Argument handling: create_config
.pre-commit-config.yaml is already exist. Make a backup of previous file
Backup has been created: .pre-commit-config-20240112210302.yaml
Creating .pre-commit-config.yaml...
.pre-commit-config.yaml is created
root@deb12-dev:/home/denis/kbot# curl -fsSL https://raw.githubusercontent.com/Dennyyyyyyy/gitleaks-check/main/pre_commit_check.sh | sh -s check_python
Your operation system is: Linux
Argument handling: check_python
Python is installed
/usr/bin/python3