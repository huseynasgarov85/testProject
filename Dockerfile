# Gradle build üçün ən uyğun image
FROM gradle:8.4-jdk17 AS build

# Kodun fayllarını kopyalayırıq
COPY . .

# Gradle ilə tətbiqi build edirik
RUN gradle build -x test

# Final image: Java 17 ilə tətbiqi işə salırıq
FROM eclipse-temurin:17-jdk

# Build edilmiş jar faylını kopyalayırıq
COPY --from=build build/libs/*.jar app.jar

# 8080 portunu açırıq
EXPOSE 8080

# Tətbiqi işə salırıq
ENTRYPOINT ["java", "-jar", "app.jar"]
