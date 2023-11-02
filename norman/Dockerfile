FROM node:18

# Installer OpenSSH Server
RUN apt-get update && apt-get install -y openssh-server \
    && echo "root:Docker!" | chpasswd \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# NodeJS setup
WORKDIR /webapp
COPY package*.json ./
COPY . .
RUN npm install
EXPOSE 3000 24678 22
CMD ["npm", "run", "dev"]
