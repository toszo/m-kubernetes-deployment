FROM alpine:3.12.0

ARG HELM_VERSION=3.3.1
ARG KUBECTL_VERSION=1.18.8

RUN apk add --update --no-cache make=4.3-r0 curl &&\
    wget https://github.com/mikefarah/yq/releases/download/3.3.4/yq_linux_amd64 -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq &&\
    echo "Installing helm binary ..." &&\
    curl -fsSLO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz &&\
    tar -xzof ./helm-v${HELM_VERSION}-linux-amd64.tar.gz --strip=1 -C /usr/local/bin linux-amd64/helm &&\
    rm ./helm-v${HELM_VERSION}-linux-amd64.tar.gz &&\
    helm version &&\
    echo "Installing kubectl binary ..." &&\
    curl -fsSLO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl &&\
    chmod +x ./kubectl &&\
    mv ./kubectl /usr/local/bin/kubectl &&\
    kubectl version --client

ARG ARG_M_VERSION="unknown"
ENV M_VERSION=$ARG_M_VERSION

ARG ARG_HOST_UID=1000
ARG ARG_HOST_GID=1000

USER $ARG_HOST_UID:$ARG_HOST_GID

ENTRYPOINT ["make"]