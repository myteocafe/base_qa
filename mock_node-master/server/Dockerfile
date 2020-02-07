FROM frolvlad/alpine-java:jdk8-slim
ADD mockserver-netty-*-jar-with-dependencies.jar mockserver.jar
ENTRYPOINT ["java","-jar","/mockserver.jar"]
CMD ["-serverPort","8080"]
