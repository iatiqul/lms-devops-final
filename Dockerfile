# Use OpenJDK as the base image
FROM openjdk:11

# Set environment variables
ENV MAVEN_VERSION=3.8.3
ENV MAVEN_HOME=/usr/share/maven

# Install Maven
RUN wget --no-verbose -O /tmp/apache-maven.tar.gz \
    https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar xzf /tmp/apache-maven.tar.gz -C /usr/share/ && \
    mv /usr/share/apache-maven-${MAVEN_VERSION} ${MAVEN_HOME} && \
    ln -s ${MAVEN_HOME}/bin/mvn /usr/bin/mvn && \
    rm -f /tmp/apache-maven.tar.gz

# Set Maven related environment variables
ENV PATH=${MAVEN_HOME}/bin:${PATH}

# Copy the application source code to the container
COPY . /app

# Set the working directory
WORKDIR /app

# Build your application
RUN mvn clean install

# Specify the default command to run when the container starts
CMD ["mvn", "spring-boot:run"]
