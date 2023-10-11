#!/bin/zsh

# script to help replace IP address of remote gcloud vm instance on ssh. 
# used for work. 

IP_ADDRESS="$1"
VM_USERNAME="$2"
CONFIG_FILE="$HOME/.ssh/config"

# Check if the config file exists
if [[ ! -f $CONFIG_FILE ]]; then
  echo "Error: $CONFIG_FILE does not exist"
  exit 1
fi

# Check if the Host block exists
if ! grep -q "Host work-gcloud" $CONFIG_FILE; then
  echo "Host work-gcloud block not found in $CONFIG_FILE"
  echo "Creating host work-gcloud block"
  cat <<EOT >> $CONFIG_FILE

Host work-gcloud
  HostName 34.84.124.13
  Port 22
  User jakeunderland2
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/google_compute_engine
  ForwardAgent yes
  ServerAliveInterval 60

EOT
fi

# Replace the IP address
gsed -E -i '/Host work-gcloud/{N; s/(Host work-gcloud\n  HostName ).*/\1'$IP_ADDRESS'/}' $CONFIG_FILE

# Replace the username 
gsed -i '/^Host work-gcloud$/,/^$/ {/User/ s/User .*/User '$VM_USERNAME'/}' $CONFIG_FILE

echo "Success: IP address updated in $CONFIG_FILE"
