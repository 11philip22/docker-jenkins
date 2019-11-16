String dockerHubUser = "philipwold" 
String repo = "jenkins"

node ("master") {
    stage ("checkout scm") {
        checkout scm
    }

    stage ("run dos2unix") {
        sh "find . -type f -print0 | xargs -0 dos2unix"
    }
        
    stage ("docker build") {
        def image = docker.build("${dockerHubUser}/${repo}")
        docker.withRegistry('https://registry-1.docker.io/v2/', '4ad791bd-6d00-41ac-aa33-ba5aeb446f25') {
            image.push()
        }
    }

    stage ("trigger dependant builds") {
        build job: "docker-build-jenkins_dind"
    }
}