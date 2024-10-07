
FROM rockylinux:9-minimal

RUN microdnf install --nodocs -y crypto-policies-scripts && \
    update-crypto-policies --set DEFAULT:SHA1 && \
    microdnf clean all

ARG NODEJS_VERSION=20

ENV npm_config_loglevel warn
ENV npm_config_unsafe_perm true

COPY <<EOT /etc/yum.repos.d/nodesource.repo
[nodesource-nodejs]
name=Node.js Packages for Linux RPM based distros
baseurl=https://rpm.nodesource.com/pub_${NODEJS_VERSION}.x/nodistro/nodejs/x86_64
priority=9
enabled=1
gpgcheck=1
gpgkey=https://rpm.nodesource.com/gpgkey/ns-operations-public.key
module_hotfixes=1
EOT

RUN microdnf --nodocs -y upgrade && \    
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
