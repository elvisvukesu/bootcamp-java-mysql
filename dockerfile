FROM eclipse-temurin:8-jdk-alpine
RUN mkdir /opt/app
COPY bootcamp-java-mysql-project-1.0-SNAPSHOT.jar /opt/app
WORKDIR /opt/app
EXPOSE 8080
CMD ["java", "-jar", "bootcamp-java-mysql-project-1.0-SNAPSHOT.jar"]
