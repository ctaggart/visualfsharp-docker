FROM microsoft/aspnet:1.0.0-beta7-coreclr
# https://hub.docker.com/r/microsoft/aspnet/
# https://github.com/aspnet/aspnet-docker

# install mono
# http://www.mono-project.com/docs/getting-started/install/linux/
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get update
RUN apt-get install -y mono-devel

# download source code
RUN curl -sSL https://github.com/KevinRansom/visualfsharp/archive/coreclr.tar.gz | tar zxfv - -C /opt
RUN mv /opt/visualfsharp-coreclr /opt/visualfsharp

# setup MSBuild
COPY project.json /opt/visualfsharp/project.json
RUN cd /opt/visualfsharp && dnu restore
COPY msbuild /root/.dnx/packages/Microsoft.Build.Mono.Debug/14.1.0-prerelease/lib/msbuild
RUN chmod u+x /root/.dnx/packages/Microsoft.Build.Mono.Debug/14.1.0-prerelease/lib/msbuild
ENV PATH /root/.dnx/packages/Microsoft.Build.Mono.Debug/14.1.0-prerelease/lib:$PATH

# lkg/FSharp-4.0.30319.1/bin/FSharp.PowerPack.Build.Tasks.dll tries to load Microsoft.Build.Utilities 2.0.0.0
# mono installs a .v4.0.dll and a .v12.0.dll
RUN ln -s /usr/lib/mono/gac/Microsoft.Build.Utilities.v12.0 /usr/lib/mono/gac/Microsoft.Build.Utilities
RUN ln -s /usr/lib/mono/gac/Microsoft.Build.Utilities/12.0.0.0__b03f5f7f11d50a3a/Microsoft.Build.Utilities.v12.0.dll /usr/lib/mono/gac/Microsoft.Build.Utilities/12.0.0.0__b03f5f7f11d50a3a/Microsoft.Build.Utilities.dll
COPY MSBuild.exe.config /root/.dnx/packages/Microsoft.Build.Mono.Debug/14.1.0-prerelease/lib/MSBuild.exe.config

# case sensitivity for the win
RUN ln -s /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/Microsoft.FSharp.targets /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/Microsoft.FSharp.Targets
COPY fsc.exe /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/fsc.exe
COPY fssrgen.exe /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/fssrgen.exe
COPY fslex.exe /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/fslex.exe
COPY fsyacc.exe /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/fsyacc.exe
RUN chmod u+x /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/fsc.exe
RUN chmod u+x /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/fssrgen.exe
RUN chmod u+x /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/fslex.exe
RUN chmod u+x /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/fsyacc.exe

# disable automatic NuGet.exe restore
# it returns an error code when everything is already restored
# remove the BeforeBuild
# https://github.com/KevinRansom/visualfsharp/blob/coreclr/src/FSharpSource.targets#L860-L863
RUN cd /opt/visualfsharp/src && head -n 859 FSharpSource.targets > temp && tail -n 1 FSharpSource.targets >> temp && mv temp FSharpSource.targets

# remove CreateFSharpManifestResourceName task
# error MSB4131: The "ResourceFilesWithManifestResourceNames" parameter is not supported by the "CreateFSharpManifestResourceName" task
COPY Microsoft.FSharp.targets /opt/visualfsharp/lkg/FSharp-4.0.30319.1/bin/Microsoft.FSharp.targets 
