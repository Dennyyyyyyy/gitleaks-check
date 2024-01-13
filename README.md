# Instruction for installing the pre-commit script

The script streamlines the process of setting up, removing, tidying, and updating pre-commit hooks within your Git repositories.

By employing pre-commit hooks, it verifies that your commits adhere to specific standards and guards against inadvertent exposure of sensitive information.

## Installation

### `! Please be attentive`; Python must be installed on your operating system.

Next command download the script using curl and run installation
```sh
$ curl -fsSL https://raw.githubusercontent.com/Dennyyyyyyy/gitleaks-check/main/pre_commit_check.sh | sh -s install
Your operation system is: Linux
Argument handling: install
The pre-commit command is already installed.
/usr/bin/pre-commit
Configuration has been migrated.
Updating https://github.com/gitleaks/gitleaks ... already up to date.
pre-commit installed at .git/hooks/pre-commit
.pre-commit-config.yaml is already exist. Make a backup of previous file
Backup has been created: .pre-commit-config-20240113170611.yaml
Creating .pre-commit-config.yaml...
Great news! Now your commits are protected from leaks
```
You also can use different arguments:
`checkpy` to check Python installation
```sh
curl -fsSL https://raw.githubusercontent.com/Dennyyyyyyy/gitleaks-check/main/pre_commit_check.sh | sh -s checkpy
Your operation system is: Linux
Argument handling: checkpy
/usr/bin/python3
Python is installed
```
`uninstall` to uninstall pre-commit
```sh
$ curl -fsSL https://raw.githubusercontent.com/Dennyyyyyyy/gitleaks-check/main/pre_commit_check.sh | sh -s uninstall
Your operation system is: Linux
Argument handling: uninstall
pre-commit uninstalled
The pre-commit command is already uninstalled.
```
`createconf` just to create .pre-commit-config.yaml file
```sh
$ curl -fsSL https://raw.githubusercontent.com/Dennyyyyyyy/gitleaks-check/main/pre_commit_check.sh | sh -s createconf
Your operation system is: Linux
Argument handling: createcon
.pre-commit-config.yaml is already exist. Make a backup of previous file
Backup has been created: .pre-commit-config-20240113190948.yaml
Creating .pre-commit-config.yaml..
```

In case if you download script manually with this command:
```sh 
curl -O https://raw.githubusercontent.com/Dennyyyyyyy/gitleaks-check/main/pre_commit_check.sh 
```
Don't forget make it executable before running
```sh
$ chmod +x pre_commit_check.sh
$ ./pre_commit_check.sh install
Your operation system is: Linux
Argument handling: install
The pre-commit command is already installed.
Updating https://github.com/pre-commit/pre-commit-hooks ... updating v3.2.0 -> v4.5.0.
Updating https://github.com/gitleaks/gitleaks ... already up to date.
pre-commit installed at .git/hooks/pre-commit
.pre-commit-config.yaml is already exist. Make a backup of previous file
Backup has been created: .pre-commit-config-20240113191257.yaml
Creating .pre-commit-config.yaml...
Great news! Now your commits are protected from leaks
```
Let's try check our commit after installation
```sh
$ git add .
$ git commit -m "check with token"
Detect hardcoded secrets.................................................Failed
- hook id: gitleaks
- exit code: 1

○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

Finding:     tokenName: REDACTED
Secret:      REDACTED
RuleID:      telegram-bot-api-token
Entropy:     4.816403
File:        helm/values.yaml
Line:        16
Fingerprint: helm/values.yaml:telegram-bot-api-token:16

4:13PM INF 1 commits scanned.
4:13PM INF scan completed in 5.07ms
4:13PM WRN leaks found: 1
```

## Additional Information

Be attentive, the Python must be installed on your system.

When utilizing this script, kindly be aware that you do so at your own discretion and risk.

Please visit official website to find detail documentaion and read more about [pre-commit}(https://pre-commit.com).

### License

This script is licensed under the MIT License. See the [LICENSE](https://github.com/Dennyyyyyyy/gitleaks-check/blob/main/LICENSE) file for details.