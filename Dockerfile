FROM rockylinux:9-minimal

RUN microdnf install --nodocs -y crypto-policies-scripts && \
    update-crypto-policies --set DEFAULT:SHA1

ARG NODEJS_VERSION=20

ENV npm_config_loglevel warn
ENV npm_config_unsafe_perm true

RUN microdnf --nodocs -y upgrade && \    
    curl -sL https://rpm.nodesource.com/pub_${NODEJS_VERSION}.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -o /tmp/nodejs.rpm && \
    rpm -i /tmp/nodejs.rpm && \
    microdnf --nodocs -y install \
    autoconf \
    automake \
    bash \
    ca-certificates \
    curl \
    bc \
    gcc-c++ \
    git \
    jq \
    libglvnd-glx \
    file \
    make \
    nodejs \
    postgresql \
    which && \
    microdnf --nodocs reinstall -y tzdata && \
    microdnf clean all && \
    rm -rf /var/cache/* /tmp/*
