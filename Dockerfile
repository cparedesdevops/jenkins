FROM jenkins/jenkins:lts

USER root

RUN apt update && apt upgrade -y

RUN apt install ca-certificates curl gnupg lsb-release -y

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt update

RUN apt install docker-ce -y

RUN usermod -aG docker jenkins
RUN chmod 777 -R /var/run

USER jenkins 
 
