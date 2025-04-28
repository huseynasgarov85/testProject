# 1. Gradle ilə build mərhələsi
FROM gradle:8.5-jdk17 AS build

# 2. Kodun bütün fayllarını container-ə kopyalayırıq
COPY . .

# 3. Gradle ilə build edirik (testləri keçməyi istəyirik)
RUN gradle build -x test

# 4. Run stage: Tətbiqin çalışması üçün minimal image
FROM eclipse-temurin:17-jdk

# 5. Build edilmiş jar faylını kopyalayırıq
COPY --from=build build/libs/*.jar app.jar

# 6. Portu açırıq
EXPOSE 8080

# 7. Java Spring Boot tətbiqini işə salırıq
ENTRYPOINT ["java", "-jar", "app.jar"]
