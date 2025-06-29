FROM jenkins/jenkins
USER root

# Actualizar e instalar dependencias básicas
RUN apt-get update && \
    apt-get -y install apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common \
        lsb-release

# Agregar la clave GPG de Docker usando el método recomendado
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Agregar el repositorio Docker
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizar e instalar Docker CE
RUN apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io

# Instalar Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Agregar jenkins al grupo docker
RUN usermod -aG docker jenkins

USER jenkins
