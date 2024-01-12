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
    # Activate a private virtual environment
    python3 -m venv pre_commit_venv
    source pre_commit_venv/bin/activate
    pip install pre-commit
    deactivate
    echo "pre-commit has been installed successfully in a virtual environment."
  elif command -v pip &>/dev/null; then
    # Deactivate a private virtual environment
    python -m venv pre_commit_venv
    source pre_commit_venv/bin/activate
    pip install pre-commit
    deactivate
    echo "pre-commit has been installed successfully in a virtual environment."
  else
    error_exit "Didn't find pip in your OS. Please install pip first before installation pre-commit"
  fi
}


# Define and install pre-commit
check_precommit() {
  # Use command -v to find the full path of pre-commit
  precommit_path=$(command -v pre-commit)
  
  if [ -n "$precommit_path" ]; then
    echo "The pre-commit command is found at: $precommit_path"
  else
    echo "The pre-commit command is not found. Installing pre-commit..."
    install_precommit
    precommit_path=$(command -v pre-commit)
    echo "pre-commit has been installed successfully at: $precommit_path"
    echo "Executing commands pre-commit..."
    $precommit_path autoupdate
    $precommit_path install -f --hook-type pre-commit
    $precommit_path
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
