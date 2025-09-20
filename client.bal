import ballerina/io;
import ballerina/grpc;

public function main() returns error? {
    // Create client
    final carrental:CarRentalServiceClient client = check new ("http://localhost:9090");
    
    io:println("====================================");
    io:println("   CAR RENTAL gRPC CLIENT");
    io:println("====================================");
    io:println("Connected to server at localhost:9090");
    
    // Test available cars
    carrental:FilterRequest filter = {search_term: ""};
    stream<carrental:Car> cars = check client->ListAvailableCars(filter);
    
    io:println("\nAVAILABLE CARS:");
    io:println("===============");
    
    int count = 0;
    check cars.forEach(function(carrental:Car car) {
        count += 1;
        io:println(count + ". " + car.make + " " + car.model + " (" + car.year.toString() + ")");
        io:println("   Plate: " + car.plate);
        io:println("   Price: $" + car.daily_price.toString() + "/day");
        io:println("   Mileage: " + car.mileage.toString() + " km");
        io:println("   Status: " + car.status);
        io:println();
    });
    
    if count == 0 {
        io:println("No cars available at the moment");
    } else {
        io:println("Total available cars: " + count.toString());
    }
    
    io:println("====================================");
    io:println("Client test completed successfully!");
    
    return ();
}