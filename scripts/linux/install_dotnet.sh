#!/bin/bash

curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --version latest
rm ./dotnet-install.sh
