FROM maven:3.9.5 AS builder
WORKDIR /app
COPY pom.xml .
COPY src src
RUN mvn package -Dmaven.test.skip=true && \
    ARTIFACTID=$(grep artifactId target/maven-archiver/pom.properties | awk -F'=' '{print $2}') && \
    VERSION=$(grep version target/maven-archiver/pom.properties | awk -F'=' '{print $2}') && \
    mv target/$ARTIFACTID-$VERSION.jar target/myapp.jar
    
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=builder /app/target/myapp.jar myapp.jar
EXPOSE 8080
ENTRYPOINT ['java', '-jar', 'myapp.jar']
