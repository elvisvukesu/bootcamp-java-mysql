Exercise 0
# Launch ubuntu t2.medium instance and install prerequisites. Use the following code as user data when launching the instance. 
  #!/bin/bash
  sudo apt-get update -y 
  sudo apt-get upgrade -y 
  sudo apt install docker.io -y
  sudo apt install docker-compose -y
  sudo apt install net-tools -y
  sudo usermod -aG docker ubuntu 
  sudo apt install java-11-openjdk-amd64 -y

# Set the JAVA_HOME path in /etc/profile
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
PATH=$PATH:$HOME/bin:$JAVA_HOME
log out as ubuntu user and log back in so that changes can take effect

# Clone the repo
cd ~
git clone https://gitlab.com/devops-bootcamp3/bootcamp-java-mysql

Exercise 1
# Start mysql container
docker run -d \
--name mysql.server \
-e MYSQL_ROOT_PASSWORD=password \
-e MYSQL_DATABASE=mysql-db \
-e MYSQL_USER=db-user \
-e MYSQL_PASSWORD=password \
-p 3306:3306 \
mysql

# Set env variables 
export DB_USER=db-user
export DB_NAME=mysql-db
export DB_SERVER=localhost
export DB_PWD=password

# Build and run the java application.
./gradlew build
cd build/libs
java -jar bootcamp-java-mysql-project-1.0-SNAPSHOT.jar

Exercise 2
# Start phpmyadmin as a container
docker run -d \
--name phpmyadmin \
-e MYSQL_ROOT_PASSWORD=password \
-e MYSQL_PASSWORD=password \
--link mysql.server:db \
-p 8081:80 \
phpmyadmin

Exercise 3
# Create a docker compose file
services:
  database:
    image: mysql
    ports: 
      - 3306:3306
    networks:
      - mysql-network
    environment:
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_DATABASE=mysql-db
      - MYSQL_USER=db-user
      - MYSQL_PASSWORD=password
    volumes:
      - db-data:/var/lib/mysql
  phpmyadmin:
    image: phpmyadmin
    links:
      - "database:db"
    ports: 
      - 8081:80
    networks:
      - mysql-network
    environment:
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_PASSWORD=password

volumes:
  db-data:
    driver: local
networks:
  mysql-network:
    driver: bridge
    
Exercise 4
# Dockerize the java app
# View base image documentation https://hub.docker.com/_/eclipse-temurin
FROM eclipse-temurin:8-jdk-alpine
RUN mkdir /opt/app
COPY bootcamp-java-mysql-project-1.0-SNAPSHOT.jar /opt/app
WORKDIR /opt/app
EXPOSE 8080
CMD ["java", "-jar", "bootcamp-java-mysql-project-1.0-SNAPSHOT.jar"]

Exercise 5
# To build and publish the image on dockerhub, follow the following steps

# Add the palantir plugin id to the plugins section of the build.gradle file
id "com.palantir.docker" version "0.22.1"

# Ensure a version is mentioned in the build.gradle file

# Add the docker configuration to the build.gradle file
# More info on plugin used https://tomgregory.com/automating-docker-builds-with-gradle/
# Create a repository in dockerhub
# Replace <dockerHub-username> with your dockerhub username and the image name with your image name
docker {
    name "${project.name}:${project.version}"
    files 'bootcamp-java-mysql-project-1.0-SNAPSHOT.jar'
    tag 'DockerHub', "elvisvukesu/java-mysql-app:${project.version}"
}

# To view available tasks from the plugin run the following command and look for the 'docker tasks' section
./gradlew tasks

# To build and push the image the required commands are 
docker login
./gradlew build
cp build/libs/bootcamp-java-mysql-project-1.0-SNAPSHOT.jar .
./gradlew dockerPushDockerHub
rm bootcamp-java-mysql-project-1.0-SNAPSHOT.jar
docker logout

# Verify dockerhub account and delete image from local machine
docker images
docker rmi -f xxxxxxxx

Exercise 6.
# Add the java web app to the docker-compose file
services:
  mysql:
    image: mysql
    container_name: mysql
    ports: 
      - 3306:3306
    networks:
      - java-app-network
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PWD}
      - MYSQL_DATABASE=${DB_NAME}
      - MYSQL_USER=${DB_USER}
      - MYSQL_PASSWORD=${DB_PWD}
    volumes:
      - db-data:/var/lib/mysql
  phpmyadmin:
    image: phpmyadmin
    container_name: phpmyadmin
    depends_on:
      - mysql
    networks:
      - java-app-network
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PWD}
      - PMA_HOST=${PMA_HOST}
      - PMA_PORT=${PMA_PORT}
  
  java-mysql-app:
    image: elvisvukesu/java-mysql-app:1.0-SNAPSHOT
    container_name: java-mysql-app
    ports:
      -8080:8080
    depends_on:
      - mysql
    networks:
      - java-app-network
    environment:
      - DB_USER=${DB_USER}
      - DB_NAME=${DB_NAME}
      - DB_SERVER=${DB_SERVER}
      - DB_PWD=${DB_PWD}

volumes:
  db-data:
    driver: local
networks:
  mysql-network:
    driver: bridge
    
# Create a shell script to export all the environmental variables needed for the containers
touch env-vars.sh

#!/bin/bash
export MYSQL_ROOT_PASSWORD=password1234
export MYSQL_DATABASE=mysql-db
export MYSQL_USER=db-user
export MYSQL_PASSWORD=password5678
export PMA_HOST=mysql
export PMA_PORT=3306
export DB_USER=db-user
export DB_NAME=mysql-db
export DB_SERVER=mysql
export DB_PWD=password5678

Exercise 7.
# Delete all images and containers running on the server

# Run the bash shell script to set the env variables

# Start the conainers using docker compose

# Access the container from the browswer 
