FROM jenkins/jenkins:lts

USER root

# install docker
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get install docker-ce=17.12.1~ce-0~debian -y

# install kubectl
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update -qq \
    && apt-get install -qqy kubectl

# install helm
RUN wget https://get.helm.sh/helm-v3.0.0-alpha.2-linux-amd64.tar.gz \
&& tar -zxvf helm-v3.0.0-alpha.2-linux-amd64.tar.gz \
&& mv linux-amd64/helm /usr/local/bin/helm

# grant docker to jenkins user
RUN usermod -aG docker jenkins
