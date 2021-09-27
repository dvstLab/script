#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2021 rzlamrr

set -e

PACKAGE_DIR="/mnt/d/Linux" # use /mnt/c instead of C:\
NEW_VERSION=$(curl --silent "https://github.com/nathanchance/WSL2-Linux-Kernel/releases/latest" | sed "s#.*tag/\(.*\)\".*#\1#")
[[ -f ${PACKAGE_DIR}/.version ]] && CURRENT_VERSION=$(cat ${PACKAGE_DIR}/.version)

if [[ "${CURRENT_VERSION}" != "${NEW_VERSION}" ]]; then
    rm -f ~/bzImage
    echo "Downloading new update (${NEW_VERSION})!"
    curl --silent -L -o ~/bzImage "https://github.com/nathanchance/WSL2-Linux-Kernel/releases/download/${NEW_VERSION}/bzImage"
    mv -f ${PACKAGE_DIR}/bzImage ${PACKAGE_DIR}/bzImage-old
    mv ~/bzImage ${PACKAGE_DIR}/bzImage
    echo "${NEW_VERSION}" > ${PACKAGE_DIR}/.version
    echo "The newest version of the WSL kernel has now been installed!"
else
    echo "Kernel is already at latest version (${CURRENT_VERSION})!"
fi

echo "Restart WSL to load the new kernel!"
