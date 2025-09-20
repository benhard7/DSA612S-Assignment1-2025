import ballerina/io;

public function main() {
    io:println("✅ Asset Management Client Ready!");
    io:println("📍 Server running on: http://localhost:9090");
    io:println("📋 Available endpoints:");
    io:println("   - GET /assets - Get all assets");
    io:println("   - POST /assets - Create new asset");
    io:println("   - Use curl or Postman to test the API");
}