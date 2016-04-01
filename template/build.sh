#!/bin/sh
dotnet restore --configfile $PWD/NuGet.Config -v Minimal
dotnet -v build
dotnet run It Works!
