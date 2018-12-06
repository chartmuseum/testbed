FROM golang:1.11.2-alpine3.8

ENV HELM_VERSION="v2.11.0"
ENV HELM_HOME="/go/src/github.com/helm/chartmuseum/.helm"

WORKDIR /go/src/github.com/helm/chartmuseum

RUN apk add --no-cache bash git make py3-pip && \
    go get -u github.com/golang/dep/cmd/dep && \
    pip3 install virtualenv awscli && \
    mkdir -p testbin/ && \
    wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | \
        tar -xzO linux-amd64/helm > testbin/helm && \
    chmod +x testbin/helm && \
    testbin/helm init --client-only && \
    testbin/helm repo list | sed -n '1!p' | awk '{print $1}' | xargs testbin/helm repo remove && \
    virtualenv -p $(which python3) .venv/ && \
    .venv/bin/python .venv/bin/pip install requests==2.20.1 robotframework==3.0.4 && \
    adduser -D -u 1000 chartmuseum

USER 1000
