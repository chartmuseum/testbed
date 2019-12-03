FROM golang:1.13.4-alpine3.10

ENV HELM_VERSION="v2.16.1"
ENV HELM_HOME="/root/.helm"

RUN apk add --no-cache bash git make py3-pip && \
    go get -u github.com/golang/dep/cmd/dep && \
    pip3 install awscli requests robotframework && \
    mkdir -p ../testbin/ && \
    wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | \
        tar -xzO linux-amd64/helm > /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    helm init --client-only && \
    helm repo list | sed -n '1!p' | awk '{print $1}' | xargs helm repo remove
