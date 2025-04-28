FROM gradle:8.5-jdk17 AS build

# Kodları konteynerə kopyalayırıq
COPY . .

# Gradle ilə tətbiqi build edirik
RUN gradle build -x test

# Java image-ını istifadə edirik
FROM eclipse-temurin:17-jdk

# Build edilmiş jar faylını kopyalayırıq
COPY --from=build /home/gradle/build/libs/*.jar app.jar

EXPOSE 8080

# Tətbiqi işə salırıq
ENTRYPOINT ["java", "-jar", "app.jar"]
