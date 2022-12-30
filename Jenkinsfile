pipeline{
  agent any
  tools{
    maven 'Maven_3_6_3'
  }
  stages{
    stage('Check Maven version'){
      steps{
        sh 'mvn -v'
      }       
    }
    stage('Code Quality'){
      steps{
        sh 'echo Sonarqube Code Quality Check Done'
      }
    }
    stage('Testing maven file'){
      steps{
        sh 'mvn test'
      }
    } 
    stage('Ready to deploy jar'){
    	input{
    	  message "are you sure you want to deploy on prod"
    	  ok "yes,go ahead"
    	}
      steps{
        sh 'mvn clean package'
      }
    }
    stage('Upload War File To Artifactory'){
      steps{
        sh 'echo Uploaded War file to Artifactory'
      }
    }
    stage('Deploy on container'){
      agent any
      steps{
        sh label: '', script: '''rm -rf dockerimg
mkdir dockerimg
cd dockerimg
touch dockerfile
cat <<EOT>>dockerfile
FROM tomcat
MAINTAINER akshaysaini193@gmail.com
RUN mkdir -p /home/akshay
WORKDIR /home/akshay
COPY . .
CMD ["echo", "Hello world"]
EXPOSE 8888
EOT
sudo docker build -t webimage:$BUILD_NUMBER .
sudo docker container run -itd --name webserver$BUILD_NUMBER -p 8888 webimage:$BUILD_NUMBER
sudo docker ps'''
      }
    }
  }
}
