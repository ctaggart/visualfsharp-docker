# https://hub.docker.com/_/ubuntu/
FROM docker.io/ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

# install all build toolchain dependencies
# TODO Whih ones are required for runtime?
# https://github.com/dotnet/coreclr/blob/master/Documentation/building/linux-instructions.md
RUN echo 'deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.6 main' | tee /etc/apt/sources.list.d/llvm.list \
  && apt-get -qq install curl \
  && curl http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add - \
  && apt-get -qq update \
  && apt-get -q -y install cmake llvm-3.5 clang-3.5 lldb-3.6 lldb-3.6-dev libunwind8 libunwind8-dev gettext libicu-dev liblttng-ust-dev libcurl4-openssl-dev libssl-dev uuid-dev

COPY dotnet /usr/share/dotnet

ENV PATH /usr/share/dotnet/bin:$PATH

# workaround bug with LTTng library & Docker < 1.11.0
# https://github.com/dotnet/cli/issues/1582
ENV LTTNG_UST_REGISTER_TIMEOUT 0

WORKDIR /root
CMD /bin/bash
