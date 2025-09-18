import ballerina/grpc;
import ballerina/log;

// Database for cars
final map<Car> carDB = {};

public function main() returns error? {
    log:printInfo("🚗 Starting Car Rental gRPC Server on port 9000");
    
    // Create gRPC listener
    grpc:Listener grpcListener = check new (9000);
    
    // Create service instance
    CarRentalService service = new;
    
    // Attach service to listener
    check grpcListener.attach(service, ());
    
    // Start the server
    check grpcListener.'start();
    
    log:printInfo("✅ Server started successfully on port 9000");
    
    // Keep server running
    while true {
        // Simple delay - replace with proper sleep later
        int counter = 0;
        while counter < 10000000 {
            counter = counter + 1;
        }
    }
}

// Service implementation - TEAM TO COMPLETE THIS
service class CarRentalService {
    
    // Add a new car to the system
    remote function AddCar(Car car) returns Car {
        log:printInfo("AddCar called for: " + car.plate_number);
        // TODO: Implement car addition logic
        return car;
    }
    
    // Search for a car by plate number
    remote function SearchCar(CarRequest request) returns Car {
        log:printInfo("SearchCar called for: " + request.plate_number);
        // TODO: Implement car search logic
        return {
            plate_number: request.plate_number,
            make: "Toyota",
            model: "Camry",
            daily_price: 50.0,
            status: "AVAILABLE"
        };
    }
    
    // TODO: Add other required methods from assignment
    // - update_car()
    // - remove_car() 
    // - list_available_cars()
    // - add_to_cart()
    // - place_reservation()
}