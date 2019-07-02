FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get -y install git cmake ninja-build clang python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev systemtap-sdt-dev tzdata rsync pkg-config zip g++ zlib1g-dev unzip python3 curl lld
#this can break if token expires, should save copy to file
RUN adduser --disabled-password --gecos "" sftf
USER sftf
COPY --chown=sftf:sftf ./bazel.sh ./bazel.sh
RUN mkdir /home/sftf/swift-source/ && chmod +x bazel.sh && ./bazel.sh --user
ENV PATH="$PATH:/home/sftf/bin"
COPY --chown=sftf:sftf ./swift /home/sftf/swift-source/swift
WORKDIR /home/sftf/swift-source/swift
RUN utils/update-checkout -j 12 --clone --scheme tensorflow --skip-repository swift
COPY --chown=sftf:sftf ./startup.sh ./startup.sh
RUN utils/build-script -j 8 --enable-tensorflow  --release-debuginfo --debug-swift-stdlib
RUN utils/build-script -j 8 --preset=tensorflow_test || true
CMD ["./startup.sh"]