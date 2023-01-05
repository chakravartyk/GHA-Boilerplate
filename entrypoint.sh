#!/bin/bash

set -xeo pipefail
mkdir ~/.ssh
chmod 0700 ~/.ssh
echo -e "Host github.com\n  CheckHostIP no" > ~/.ssh/config
curl --silent https://api.github.com/meta | \
  python3 -c 'import json,sys;print(*["github.com " + x for x in json.load(sys.stdin)["ssh_keys"]], sep="\n")' \
  >> ~/.ssh/known_hosts
chmod 0600 ~/.ssh/known_hosts
sudo curl -Ls https://raw.githubusercontent.com/gruntwork-io/gruntwork-installer/"$1"/bootstrap-gruntwork-installer.sh | bash /dev/stdin --version "$1"
gruntwork-install --binary-name 'boilerplate' --repo 'https://github.com/gruntwork-io/boilerplate' --tag "$2" --no-sudo