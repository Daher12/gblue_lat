#!/bin/bash

set -ouex pipefail

### Install packages

dnf5 -y copr enable ublue-os/akmods 
dnf5 -y copr enable scottames/ghostty
dnf5 -y copr enable chenxiaolong/sbctl
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

dnf5 install -y ghostty fish nautilus sbctl tailscale gnome-shell gnome-tweaks tlp --setopt=install_weak_deps=False

rm /etc/yum.repos.d/tailscale.repo /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:chenxiaolong:sbctl.repo /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:scottames:ghostty.repo /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:ublue-os:akmods.repo


## Nix
mkdir -p /nix 
mkdir -p /usr/dp

curl -L https://github.com/displaylink-rpm/displaylink-rpm/releases/download/v6.1.1-1/fedora-42-displaylink-1.14.10-1.github_evdi.x86_64.rpm -o /usr/dp/dp.rpm && \
dnf5 install -y /usr/dp/dp.rpm

## Ox
curl -L https://github.com/curlpipe/ox/releases/latest/download/ox -o /usr/bin/ox && \
chmod +x /usr/bin/ox

systemctl enable tlp
systemctl enable tailscaled


