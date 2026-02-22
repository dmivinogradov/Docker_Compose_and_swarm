FROM eclipse-temurin:17-jdk-alpine AS builder

RUN apk add --no-cache bash

WORKDIR /loyalty-service

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

COPY src ./src

RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine

RUN apk add --no-cache bash postgresql-client

WORKDIR /loyalty-service

COPY --from=builder /loyalty-service/target/*.jar loyalty-service.jar

COPY wait-for-it.sh .
RUN chmod +x wait-for-it.sh

RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
    CMD nc -z localhost 8085 || exit 1

EXPOSE 8085

ENTRYPOINT ["./wait-for-it.sh", "database:5432", "-t", "30", "--", "java", "-jar", "loyalty-service.jar"]

