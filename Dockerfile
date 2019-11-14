FROM archlinux/base

FROM archlinux/base

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=976
ARG jenkins_home=/var/jenkins_home

# Create Jenkins user
RUN groupadd -g ${gid} ${group}; \
    useradd -d ${jenkins_home} -u ${uid} -g ${gid} -m -s /bin/nologin ${user}; \
    chown ${uid}:${gid} /var/jenkins_home
ENV JENKINS_HOME ${jenkins_home}

# Jenkins dependancies
RUN pacman -Sy docker docker-composejava-runtime-common jre8-openjdk libfontenc \
           libxmu  libxt nspr  nss  ttf-dejavu  xdg-utils jre8-openjdk-headless \
           xorg-fonts-encodings  xorg-mkfontscale  xorg-xset --noconfirm
# Additional programs
RUN pacman -S wget git openssh dos2unix --noconfirm        
# Remove pacman cache and database
RUN pacman -Scc --noconfirm

# Download Jenkins war file
RUN mkdir /usr/share/jenkins; \
    wget -q http://mirrors.jenkins.io/war-stable/latest/jenkins.war \
    --output-document=/usr/share/jenkins/jenkins.war

USER ${user}
CMD java -jar /usr/share/jenkins/jenkins.war --httpPort=8090

EXPOSE 8090/tcp
VOLUME [ ${jenkins_home}} ]