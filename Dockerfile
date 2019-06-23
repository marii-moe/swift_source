FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get -y install git cmake ninja-build clang python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev systemtap-sdt-dev tzdata rsync pkg-config zip g++ zlib1g-dev unzip python3 curl
#this can break if token expires, should save copy to file
RUN adduser --disabled-password --gecos "" sftf
USER sftf
COPY --chown=sftf:sftf ./bazel.sh ./bazel.sh
RUN chmod +x bazel.sh && ./bazel.sh --user
ENV PATH="$PATH:/home/sftf/bin"
RUN mkdir /home/sftf/swift-source
COPY --chown=sftf:sftf . /home/sftf/swift-source/
#COPY --chown=sftf:sftf ./clang /home/sftf/swift-source/clang
#COPY --chown=sftf:sftf ./clang-tools-extra /home/sftf/swift-source/clang-tools-extra
#COPY --chown=sftf:sftf ./cmark /home/sftf/swift-source/cmark
#COPY --chown=sftf:sftf ./compiler-rt /home/sftf/swift-source/compiler-rt
#COPY --chown=sftf:sftf ./icu /home/sftf/swift-source/icu
#COPY --chown=sftf:sftf ./indexstore-db /home/sftf/swift-source/indexstore-db
#COPY --chown=sftf:sftf ./libcxx /home/sftf/swift-source/libcxx
#COPY --chown=sftf:sftf ./llbuild /home/sftf/swift-source/llbuild
#COPY --chown=sftf:sftf ./lldb /home/sftf/swift-source/lldb
#COPY --chown=sftf:sftf ./llvm /home/sftf/swift-source/llvm
#COPY --chown=sftf:sftf ./ninja /home/sftf/swift-source/ninja
#COPY --chown=sftf:sftf ./sourcekit-lsp /home/sftf/swift-source/sourcekit-lsp
#COPY --chown=sftf:sftf ./swift-corelibs-foundation /home/sftf/swift-source/swift-corelibs-foundation
#COPY --chown=sftf:sftf ./swift-corelibs-libdispatch /home/sftf/swift-source/swift-corelibs-libdispatch
#COPY --chown=sftf:sftf ./swift-corelibs-xctest /home/sftf/swift-source/swift-corelibs-xctest
#COPY --chown=sftf:sftf ./swift-integration-tests /home/sftf/swift-source/swift-integration-tests
#COPY --chown=sftf:sftf ./swiftpm /home/sftf/swift-source/swiftpm
#COPY --chown=sftf:sftf ./swift-stress-tester /home/sftf/swift-source/swift-stress-tester
#COPY --chown=sftf:sftf ./swift-syntax /home/sftf/swift-source/swift-syntax
#COPY --chown=sftf:sftf ./swift-xcode-playground-support /home/sftf/swift-source/swift-xcode-playground-support
#COPY --chown=sftf:sftf ./tensorflow /home/sftf/swift-source/tensorflow
#COPY --chown=sftf:sftf ./tensorflow-swift-apis /home/sftf/swift-source/tensorflow-swift-apis
#WORKDIR /home/sftf/swift-source/swift