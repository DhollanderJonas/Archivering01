import groovy.json.JsonSlurper
import org.apache.commons.httpclient.HttpClient
import org.apache.commons.httpclient.methods.GetMethod

def proxy = "10.100.198.200"
def consul = "http://10.100.192.200:8500"
def envs = [
        "FLOW_PROXY_HOST=${proxy}",
        "FLOW_PROXY_RECONF_PORT=8081",
        "FLOW_CONSUL_ADDRESS=${consul}",
        "FLOW_PROXY_DOCKER_HOST=tcp://${proxy}:2375",
        "DOCKER_HOST=tcp://swarm-master:2375"
]

node("cd") {
    git "https://github.com/jmenga/todobackend.git"

    try{
        stage 'Run unit/integration tests'
        sh 'make test'

        stage 'Build application artefacts'
        sh 'make build'

        stage 'Create release enviroment and run acceptance tests'
        sh 'make release'

        stage 'Tag and plublish release image'
        sh "make tag latest \$(git rev-parse --short HEAD) \$(git tag --points-at HEAD)"
        sh "make buildtag master \$(git tag --points-at HEAD)"
        withEnv(["DOCKER_USER=${DOCKER_USER}",
                "DOCKER_PASSWORD=$DOCKER_PASSWORD}",
                "DOCKER-EMAIL=${DOCKER_EMAIL}"]){
            sh "make login"
        }

        sh "make publish"
    }
    finally{
        stage 'Collect test reports'
        step([$class: 'JUnitResultArchiver', testResults: '**/reports/*.xml'])

        stage 'Clean up'
        sh 'make clean'
        sh 'make logout'
    }
}

