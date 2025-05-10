FROM jenkins/jenkins:lts

USER root

# Instala Docker, Python 3, pip y venv
RUN apt-get update && \
    apt-get install -y \
        docker.io \
        python3 \
        python3-pip \
        python3-venv && \
    apt-get clean

# Da permisos al usuario Jenkins para usar Docker
RUN usermod -aG docker jenkins

USER jenkins
