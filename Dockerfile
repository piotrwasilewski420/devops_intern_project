# Step 1: Build the application with Gradle
FROM gradle:jdk11 AS builder

# Set the working directory
WORKDIR /home/gradle/project

# Copy the Gradle files and source code
COPY --chown=gradle:gradle build.gradle gradlew gradlew.bat settings.gradle ./
COPY --chown=gradle:gradle src/ src/
RUN ls -la
# Build the application with Gradle
RUN ./gradlew build 

# Step 2: Create a minimal Docker image with the application JAR
FROM openjdk:11-jre-slim

# Set the working directory and copy the application JAR
WORKDIR /app
COPY --from=builder /home/gradle/project/build/libs/petclinic-*.jar ./petclinic.jar

# Set the default command to run the application
CMD ["java", "-jar", "petclinic.jar"]
