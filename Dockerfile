# Java 17 istifadə edirik
FROM openjdk:17-jdk-slim

# App jar faylını konteynerə kopyalayırıq
COPY target/*.jar app.jar

# App-i çalışdırırıq
ENTRYPOINT ["java","-jar","/app.jar"]
