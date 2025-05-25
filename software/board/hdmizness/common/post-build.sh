#!/bin/bash

set -x

[[ "${TARGET_DIR}" == "" ]] && exit 0

# Generate server ssh keys
mkdir -p "${TARGET_DIR}/etc/ssh"
for kind in dsa rsa ed25519; do
    key="${TARGET_DIR}/etc/ssh/ssh_host_${kind}_key"
    if [ ! -f "$key" ]; then
        ssh-keygen -q -N "" -t $kind -f "$key"
    fi
done

# cleanup unneeded console fonts
find "${TARGET_DIR}/usr/share/consolefonts" -type f | \
	grep -v gr737b-9x16-medieval.psfu.gz | \
	grep -v t.fnt.gz | \
	xargs -d '\n' rm -f

# remove zsh functions bloat
find "${TARGET_DIR}/usr/share/zsh" -name functions -type d | xargs -d '\n' rm -rf
