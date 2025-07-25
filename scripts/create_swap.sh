#!/usr/bin/env bash
set -e

# Create 1 GB swapfile if it doesn't already exist
if [ ! -f /swapfile ]; then
  (fallocate -l 1G /swapfile || dd if=/dev/zero of=/swapfile bs=1M count=1024)
  chmod 600 /swapfile
  mkswap /swapfile
fi

# Enable the swapfile
swapon /swapfile || true

# Persist across reboots
if ! grep -q '^/swapfile' /etc/fstab ; then
  echo '/swapfile none swap sw 0 0' >> /etc/fstab
fi

# Tune swappiness
sysctl vm.swappiness=10
echo 'vm.swappiness=10' > /etc/sysctl.d/99-swappiness.conf
