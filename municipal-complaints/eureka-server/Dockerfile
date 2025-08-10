FROM eclipse-temurin:17-jre
ARG JAR_FILE=target/eureka-server-1.0.0.jar
WORKDIR /app
COPY ${JAR_FILE} app.jar
EXPOSE 8761
ENTRYPOINT ["java","-jar","/app/app.jar"]