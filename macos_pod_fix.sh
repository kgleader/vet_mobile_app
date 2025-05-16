#!/bin/bash

cd macos
pod repo update
pod install --repo-update
cd ..

echo "Pod dependencies updated! Try running your app again."
