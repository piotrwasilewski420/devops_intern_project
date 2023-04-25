# Step 1: Build the application with Gradle
FROM openjdk AS builder
RUN microdnf install findutils
# Set the working directory
WORKDIR /app

# Copy the Gradle files and source code
COPY . .
# Build the application with Gradle
RUN ./gradlew bootJar --no-daemon

# Step 2: Create a minimal Docker image with the application JAR
FROM openjdk
RUN microdnf install findutils
# Set the working directory and copy the application JAR
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar ./petclinic.jar

# Set the default command to run the application
CMD ["java", "-jar", "petclinic.jar"]
