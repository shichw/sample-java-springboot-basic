FROM maven:3.9.5 AS builder

WORKDIR /app
COPY pom.xml .
COPY src src
RUN mvn package -Dmaven.test.skip=true

FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=builder /app/target/export-run-artifact.jar  /deployments/export-run-artifact.jar
EXPOSE 8081
ENTRYPOINT ["/opt/jboss/container/java/run/run-java.sh", "--server.port=8081"]

