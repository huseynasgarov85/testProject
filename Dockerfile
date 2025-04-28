# 1. Build stage
FROM gradle:8.5-jdk17 AS build

# 2. Source kodu container-ə kopyala
COPY . .

# 3. Gradle ilə build et
RUN gradle build -x test

# 4. Run stage
FROM eclipse-temurin:17-jdk

# 5. Hazır jar-ı copy elə
COPY --from=build build/libs/*.jar app.jar

# 6. Port aç
EXPOSE 8080

# 7. App-i işə sal
ENTRYPOINT ["java", "-jar", "app.jar"]
