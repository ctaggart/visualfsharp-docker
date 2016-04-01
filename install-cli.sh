#!/bin/sh
curl -O https://dotnetcli.blob.core.windows.net/dotnet/dev/Binaries/$CLI_VERSION/dotnet-ubuntu-x64.$CLI_VERSION.tar.gz
mkdir dotnet
tar xzvf dotnet-ubuntu-x64.$CLI_VERSION.tar.gz -C dotnet
