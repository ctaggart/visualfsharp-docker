#!/bin/sh
curl -L https://www.myget.org/F/fsharp-daily/api/v2/package/Microsoft.FSharp.Compiler.netcore/$FSHARP_VERSION -o Microsoft.FSharp.Compiler.netcore.$FSHARP_VERSION.nupkg
curl -L https://www.myget.org/F/fsharp-daily/api/v2/package/Microsoft.FSharp.Core.netcore/$FSHARP_VERSION -o Microsoft.FSharp.Core.netcore.$FSHARP_VERSION.nupkg

unzip -jo Microsoft.FSharp.Compiler.netcore.$FSHARP_VERSION.nupkg lib/DNXCore50/fsc.exe lib/DNXCore50/FSharp.Compiler.dll lib/DNXCore50/fsi.exe lib/DNXCore50/FSharp.Compiler.Interactive.Settings.dll -d dotnet/bin
unzip -jo Microsoft.FSharp.Core.netcore.$FSHARP_VERSION.nupkg lib/DNXCore50/FSharp.Core.dll lib/DNXCore50/FSharp.Core.sigdata lib/DNXCore50/FSharp.Core.optdata -d dotnet/bin

cp scripts/fsc dotnet/bin
cp scripts/fsi dotnet/bin
