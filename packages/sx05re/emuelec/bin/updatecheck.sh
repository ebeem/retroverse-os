#!/bin/bash
cd /storage/roms
update_directory=/storage/roms/retroverse-os-patches
update_repo=http://github.com/ebeem/retroverse-os-patches
if [ ! -d "$update_directory" ]; then
  git clone "$update_repo"
fi

cd $update_directory
arguments="$@"

# check if any updates are available
git remote update &>/dev/null
available=$(git status | grep "Your branch is behind" | sed 's/[^0-9]//g')
current=$(git rev-list --count HEAD)

function check_update() {
  if [[ "$arguments" == *"canupdate"* ]]; then
    echo "1.0 $($current + $available)"
  elif [[ "$arguments" == *"geturl"* ]]; then
    echo "$update_repo"
  elif [[ "$arguments" == *"getsize"* ]]; then
    echo "~1MB"
  fi
}

function forced_update() {
  chmod 755 -R ./storage/.config/emuelec/scripts
  ./storage/.config/emuelec/scripts/emuelec-upgrade
}

case $available in
  '' | *[!0-9]*)
    echo "no"
    exit 1
    ;;
  *)
    check_update
    ;;
esac

if [[ "$arguments" == *"forceupdate"* ]]; then
  # run the update script
  chmod 755 -R ./storage/.config/emuelec/scripts
  ./storage/.config/emuelec/scripts/emuelec-upgrade
fi
