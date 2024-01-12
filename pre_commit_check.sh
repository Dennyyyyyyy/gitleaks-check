#!/bin/bash

# Define your OS
os_name=$(uname)

# Function to display an error message and exit the script
error_exit() {
  echo "$1" >&2
  exit 1
}

# Check if Python is installed
check_python() {
  if command -v python3 &>/dev/null; then
    echo "Python is installed"
  else
    error_exit "Didn't find Python in your system. Please install Python first before using this script."
  fi
}

# Function installation pre-commit to your system
install_precommit() {
  echo "Installation pre-commit..."
  if command -v pip3 &>/dev/null; then
    pip3 install pre-commit
  elif command -v pip &>/dev/null; then
    pip install pre-commit
  else
    error_exit "Didn't find pip in your OS. Please install pip first before installation pre-commit"
  fi
}

# Define and install pre-commit
check_precommit() {
  if command -v pre-commit &>/dev/null; then
     echo "The pre-commit command is already installed."
  else
    echo "The pre-commit command is missing in your system"
    install_precommit 
    echo "pre-commit has been installed succesfully"
    echo "Executing commands pre-commit..."
    pre-commit autoupdate
    pre-commit install -f --hook-type pre-commit
    pre-commit
    git config pre-commit.gitleaks true
    create_precommit_config
    echo "Great news! Now your commits are protected from leaks"
  fi
}

# Function of creating .pre-commit-config.yaml file
create_precommit_config() {
  if [ -e .pre-commit-config.yaml ]; then
    echo ".pre-commit-config.yaml is already exist. Make a backup of previous file"
    backup_pre_commit_yaml=".pre-commit-config-$(date +"%Y%m%d%H%M%S").yaml"
    mv .pre-commit-config.yaml "$backup_pre_commit_yaml"
    echo "Backup has been created: $backup_pre_commit_yaml"
    echo "Creating .pre-commit-config.yaml..."
    echo "- repo: https://github.com/gitleaks/gitleaks" > .pre-commit-config.yaml
    echo "  rev: v8.18.1" >> .pre-commit-config.yaml
    echo "  hooks:" >> .pre-commit-config.yaml
    echo "    - id: gitleaks" >> .pre-commit-config.yaml
    echo ".pre-commit-config.yaml is created"
  fi
}

for arg in "$@"; do
  echo "Your operation system is: $os_name"
  echo "Argument handling: $arg"
    case "$arg" in
    check_python)
      check_python
      ;;
    install_precommit)
      check_precommit
      ;;
    create_config)
      create_precommit_config
      ;;
    *)
      echo "Sorry, don't know that argument: $1"
      exit 1
      ;;
  esac
done
