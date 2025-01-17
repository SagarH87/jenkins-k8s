FROM jenkins/jenkins:lts

# Running as root to have an easy support for Docker
USER root

# Jenkins init scripts
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/

# Install Jenkins plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugin.sh $(cat /usr/share/jenkins/plugins.txt) && \
    mkdir -p /usr/share/jenkins/ref/ && \
    echo lts > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo lts > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

# Install Docker, kubectl and helm
#RUN apt-get -qq update && \
#    apt-get -qq -y install curl && \
#    curl -sSL https://get.docker.com/ | sh && \
#    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
#    chmod +x ./kubectl && \
#    mv ./kubectl /usr/local/bin/kubectl

