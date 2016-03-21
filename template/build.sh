#!/bin/sh
dotnet restore --configfile $PWD/NuGet.Config -v Minimal
# workaround https://github.com/Microsoft/visualfsharp/issues/1015
ln -sf /root/.nuget/packages/Microsoft.FSharp.Core.netcore/1.0.0-alpha-160318/runtimes/any/native/FSharp.Core.optdata /root/.nuget/packages/Microsoft.FSharp.Core.netcore/1.0.0-alpha-160318/lib/DNXCore50/FSharp.Core.optdata
ln -sf /root/.nuget/packages/Microsoft.FSharp.Core.netcore/1.0.0-alpha-160318/runtimes/any/native/FSharp.Core.sigdata /root/.nuget/packages/Microsoft.FSharp.Core.netcore/1.0.0-alpha-160318/lib/DNXCore50/FSharp.Core.sigdata
dotnet -v build
dotnet run It Works!
