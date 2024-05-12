node() {
    
    stage('Git Checkout'){
        git 'https://github.com/rakenkou-github/Jenkins-Docker-Project.git' 
    }
    
    stage("docker build"){
            sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
            sh 'docker image tag $JOB_NAME:v1.$BUILD_ID akenkour/$JOB_NAME:v1.$BUILD_ID'
            sh 'docker image tag $JOB_NAME:v1.$BUILD_ID akenkour/$JOB_NAME:latest'
    }
    
    stage("push Image: DOCKERHUB"){
        withCredentials([string(credentialsId: 'docker_passwd', variable: 'docker_passwd')]) {
            sh "docker login -u akenkour -p ${docker_passwd}"
            sh 'docker image push akenkour/$JOB_NAME:v1.$BUILD_ID'
            sh 'docker image push akenkour/$JOB_NAME:latest'
            //A number of images will get stored into our jenkins server so need to remove prev build images
            //local images,taged images & latest images all delete 
            sh 'docker image rm $JOB_NAME:v1.$BUILD_ID akenkour/$JOB_NAME:v1.$BUILD_ID akenkour/$JOB_NAME:latest'
        }
    }
    
    stage("Docker Container Deployment"){
        def docker_run = 'docker run -itd --name scriptedcontainer -p 9000:80 akenkour/docker-groovy-webapp:latest'
        def docker_rmv_container = 'docker rm -f scriptedcontainer'
        def docker_rmi = 'docker rmi -f akenkour/docker-groovy-webapp'
        // container deployment need to be done on remote host server DOCKER-Host so ssh-Agent plugin required in jenkins
        sshagent(['webapp_server']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.20.10.104 ${docker_rmv_container}"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.20.10.104 ${docker_rmi}"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.20.10.104 ${docker_run}"
        }
    }
   
}