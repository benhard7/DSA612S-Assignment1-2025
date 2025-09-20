import ballerina/io;

// This is a simple server starter
// The actual gRPC service is in car_rental_sample_service.bal

public function main() {
    io:println("================================");
    io:println("   CAR RENTAL SYSTEM SERVER");
    io:println("================================");
    io:println("Server is starting...");
    io:println("The gRPC service will run on port 9090");
    io:println("Run: bal run car_rental_sample_service.bal");
    io:println("================================");
}