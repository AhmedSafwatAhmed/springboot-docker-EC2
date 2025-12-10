FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /build

COPY ./pom.xml ./
COPY ./src ./src

#maven command , to have exe jar file
RUN mvn clean package -DskipTests


#stage 2 to run exe jar file
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /build/target/*.jar ./app.jar

#expose port
EXPOSE 80

#specify entry point
CMD ["java", "-jar", "app.jar"]

