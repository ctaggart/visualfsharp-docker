#!/bin/sh
curl -L https://www.myget.org/F/dotnet-buildtools/api/v2/package/MSBuild/$MSBUILD_VERSION -o MSBuild.$MSBUILD_VERSION.nupkg
curl -L https://www.myget.org/F/dotnet-buildtools/api/v2/package/Microsoft.Build/$MSBUILD_VERSION -o Microsoft.Build.$MSBUILD_VERSION.nupkg
curl -L https://www.myget.org/F/dotnet-buildtools/api/v2/package/Microsoft.Build.Framework/$MSBUILD_VERSION -o Microsoft.Build.Framework.$MSBUILD_VERSION.nupkg
curl -L https://www.myget.org/F/dotnet-buildtools/api/v2/package/Microsoft.Build.Tasks.Core/$MSBUILD_VERSION -o Microsoft.Build.Tasks.Core.$MSBUILD_VERSION.nupkg
curl -L https://www.myget.org/F/dotnet-buildtools/api/v2/package/Microsoft.Build.Utilities.Core/$MSBUILD_VERSION -o Microsoft.Build.Utilities.Core.$MSBUILD_VERSION.nupkg
curl -L https://www.myget.org/F/dotnet-buildtools/api/v2/package/Microsoft.Build.Targets/$MSBUILD_VERSION -o Microsoft.Build.Targets.$MSBUILD_VERSION.nupkg

# add libraries to dotnet cli directory
unzip -jo MSBuild.$MSBUILD_VERSION.nupkg runtimes/any/native/MSBuild.exe -d dotnet/bin
unzip -jo Microsoft.Build.$MSBUILD_VERSION.nupkg lib/dotnet/Microsoft.Build.dll -d dotnet/bin
unzip -jo Microsoft.Build.Framework.$MSBUILD_VERSION.nupkg lib/dotnet/Microsoft.Build.Framework.dll -d dotnet/bin
unzip -jo Microsoft.Build.Tasks.Core.$MSBUILD_VERSION.nupkg lib/dotnet/Microsoft.Build.Tasks.Core.dll -d dotnet/bin
unzip -jo Microsoft.Build.Utilities.Core.$MSBUILD_VERSION.nupkg lib/dotnet/Microsoft.Build.Utilities.Core.dll -d dotnet/bin

cp scripts/msbuild dotnet/bin

# put targets in another folder
unzip -o Microsoft.Build.Targets.$MSBUILD_VERSION.nupkg -d Microsoft.Build.Targets
