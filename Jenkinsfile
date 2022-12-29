pipeline{
  agent any
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
    stage(Ready to deploy on prod)
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
cp /home/akshay/Downloads/mvn-testing-spring-boot-project/spring-boot-hello-world/target/spring-boot-hello-1.0.jar .
touch dockerfile
cat <<EOT>>dockerfile
FROM tomcat
ADD spring-boot-hello-1.0.jar /usr/local/tomcat/webapps/
CMD ["java", "-Dserver.port=8888","-jar","spring-boot-hello-1.0.jar"]
EXPOSE 8888
EOT
sudo docker build -t webimage:$BUILD_NUMBER .
sudo docker container run -itd --name webserver$BUILD_NUMBER -p 8888 webimage:$BUILD_NUMBER'''
      }
    }
  }
}
