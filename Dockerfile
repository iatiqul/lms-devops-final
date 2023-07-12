FROM adoptopenjdk/openjdk11:alpine-jre
FROM maven:3.6.3
LABEL MAINTAINER="atiqul.islam@bjitacademy.com"

# Copy the application source code to the container
COPY . /app

# Set the working directory
WORKDIR /app

# Build your application
RUN mvn clean install

EXPOSE 8090

# Specify the default command to run when the container starts
CMD ["mvn", "spring-boot:run"]
