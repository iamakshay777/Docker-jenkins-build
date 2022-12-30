FROM tomcat
MAINTAINER akshaysaini193@gmail.com
RUN mkdir -p /home/akshay
WORKDIR /home/akshay
ADD target/spring-boot-hello-1.0.jar /usr/local/tomcat/webapps/
ENTRYPOINT ["java", "-Dserver.port=8888","-jar","spring-boot-hello-1.0.jar"]
EXPOSE 8888
