# docker-jenkins
```yml
version : "3.7"

services:
  jenkins:
    image: philipwold/jenkins-dind
    volumes:
      - ./jenkins:/var/jenkins_home
    ports:
      - 8082:8090
      - 50000:50000
    restart: unless-stopped
```