import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Create a client to connect to our service
    http:Client _ = check new ("http://localhost:9090");
    
    // This will be our test client
    io:println("✅ Asset Management Client is ready!");
    io:println("📍 Server running on: http://localhost:9090");
    
    // We'll add more code here later to test our API
}