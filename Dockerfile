FROM golang:1.11.2-alpine3.8

WORKDIR /go/src/github.com/helm/chartmuseum

RUN apk add --no-cache bash git make py3-pip && \
    go get -u github.com/golang/dep/cmd/dep && \
    pip3 install virtualenv awscli && \
    adduser -D -u 1000 chartmuseum

USER 1000
