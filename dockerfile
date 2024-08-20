FROM jenkins/jenkins:lts
USER root
# FROM jenkins/jenkins:2.462.1-jdk17
# USER root

# installs lsb release and maven
RUN apt-get update && apt-get install -y lsb-release maven zip 
# download docker keyring
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
# allow docker to access the dockerson 
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
# runs set up for node
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
# install docker, node, kubernetes
RUN apt-get update && apt-get install -y docker-ce-cli nodejs kubernetes-client
RUN export M2_HOME=/usr/bin/mvn; export MAVEN_HOME=/usr/bin/mvn
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN apt install docker.io -y
RUN ./aws/install
# additional plugins
RUN jenkins-plugin-cli --plugins "maven-plugin workflow-aggregator git sonar nodejs kubernetes aws-credentials docker-workflow ssh-agent email-ext blueocean pipeline-aws docker-plugin"

# run it with: docker build -t myjenkins-blueocean . 

# docker network create jenkins

# docker run --name jenkins --restart=on-failure --detach `
#   --network jenkins `
#   --volume /var/run/docker.sock:/var/run/docker.sock `
#   --volume jenkins-data:/var/jenkins_home `
#   --publish 8080:8080 --publish 50000:50000 myjenkins-blueocean

# docker logs to find password

# docker exec -t jenkins