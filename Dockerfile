FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl3 \
        libicu55 \
        libunwind8 \
        netcat \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# Install Docker
ENV DOCKER_VERSION 19.03.6
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz \
    && tar --strip-components=1 -xvzf docker-$DOCKER_VERSION.tgz -C /usr/local/bin && rm docker-$DOCKER_VERSION.tgz

# Install Terraform
ENV TERRAFORM_VERSION 0.12.20
RUN curl -fsSLO https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
    && chmod 755 /usr/local/bin/terraform && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
