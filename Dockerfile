# Get the Jenkins image
FROM jenkins/jenkins:2.260

# Environment Variables
ENV PHP_VERSION=7.3

# Temporary for development purposes - this should be removed in the future
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# We want the Jenkins image to have access to a few other resources
USER root
RUN \
  apt-get update && \
  apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    lsb-release \
    wget \
    git \
    nano \
    software-properties-common

# We don't want to stay as root, so lets go back to being Jenkins
# before executing the Jenkins entrypoint
USER jenkins

# Copy & install the plugins we want to use
COPY misc/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Update Jenkins settings to use the CrewNode theme
COPY misc/crewnode-theme.css ${JENKINS_HOME}/userContent/crewnode-theme.css
COPY misc/settings.groovy /usr/share/jenkins/ref/init.groovy.d/crewnode-settings.groovy

# Go back to root to fix perm issues
USER root
