#!/bin/sh

set -e

CLONE_DIR=${1:-'gecko-dev'}

echo "Welcome to the Dot Browser bootstrapper tool!"
echo "Cloning will begin momentarily under the '$CLONE_DIR' path."
echo ""

sleep 2

echo "Step 1: Cloning required repositories..."
set -x

git clone https://github.com/dothq/gecko-dev $CLONE_DIR
cd $CLONE_DIR
git clone https://github.com/dothq/browser-desktop dot/
cd dot
python3 ./scripts/install_mach_commands.py

set +x

echo "Step 3: Setting up repositories..."
set -x

./mach --no-interactive bootstrap --application-choice browser
rm -rf ./mozconfig ../mozconfig
./mach --no-interactive import-patches

set +x

cd ..
$EDITOR mozconfig

echo "Successfully bootstrapped Dot Browser."
echo "You can start compilation at any time by running |./mach build|."
echo ""