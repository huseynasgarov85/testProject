# 1. İlk öncə Gradle istifadə edib build edirik
FROM gradle:8.5-jdk17 AS build

# 2. Source kodu copy edirik
COPY --no-cache . .

# 3. Gradle ilə build edirik (tests-i keçmək istəsən --no-daemon əlavə edə bilərik)
RUN gradle build -x test

# 4. İndi başqa bir image istifadə edirik
FROM eclipse-temurin:17-jdk

# 5. Build edilmiş jar faylını götürürük
COPY --from=build build/libs/*.jar app.jar

# 6. Port açırıq
EXPOSE 8080

# 7. App-i işə salırıq
ENTRYPOINT ["java", "-jar", "app.jar"]
