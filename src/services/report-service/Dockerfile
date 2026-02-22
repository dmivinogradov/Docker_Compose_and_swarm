FROM eclipse-temurin:17-jdk-alpine AS builder

RUN apk add --no-cache bash

WORKDIR /report-service

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

COPY src ./src

RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine

RUN apk add --no-cache bash postgresql-client

WORKDIR /report-service

COPY --from=builder /report-service/target/*.jar report-service.jar

COPY wait-for-it.sh .
COPY entrypoint.sh .
RUN chmod +x wait-for-it.sh entrypoint.sh

RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
    CMD nc -z localhost 8086 || exit 1

EXPOSE 8086

ENTRYPOINT ["./entrypoint.sh"]
