FROM eclipse-temurin:8-jdk-alpine
RUN mkdir /app
COPY build/libs/bootcamp-java-mysql-project-1.0-SNAPSHOT.jar /app
WORKDIR /app
EXPOSE 8080
CMD ["java", "-jar", "bootcamp-java-mysql-project-1.0-SNAPSHOT.jar"]
