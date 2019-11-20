String dockerHubUser = "philipwold" 
String repo = "jenkins"

try {
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
    }
}

catch(err){
    println(err.toString())
    error(err.getMessage())
    currentBuild.result = 'FAILED'
    exception_msg = err.getMessage();
}

finally {
    stage('Clean Workspace') {
        cleanWs()
    }
}