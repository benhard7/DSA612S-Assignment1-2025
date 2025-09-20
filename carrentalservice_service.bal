import ballerina/grpc;
import ballerina/io;

// In-memory database
map<Car> carInventory = {};
map<string[]> userCarts = {};

# Provides operations for car rental management
@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR_CAR_RENTAL,
    descMap: getDescriptorMapCarRental()
}
service "CarRentalService" on new grpc:Listener(9090) {

    # Adds a new car to the system
    remote function AddCar(Car car) returns CarResponse {
        io:println("AddCar called for plate: " + car.plate);
        
        if car.plate == "" {
            return {message: "Plate number is required", success: false};
        }
        
        if carInventory.hasKey(car.plate) {
            return {message: "Car already exists", success: false};
        }
        
        carInventory[car.plate] = car;
        return {
            car: car,
            message: "Car added successfully",
            success: true
        };
    }

    # Creates multiple users in the system
    remote function CreateUsers(stream<User, grpc:Error?> userStream) returns UserResponse|error {
        int userCount = 0;
        check userStream.forEach(function(User user) {
            userCount += 1;
            io:println("User created: " + user.username + " (" + user.role + ")");
        });
        
        return {
            message: "Users created successfully",
            users_created: userCount
        };
    }

    # Updates an existing car's details
    remote function UpdateCar(Car updatedCar) returns CarResponse {
        io:println("UpdateCar called for plate: " + updatedCar.plate);
        
        if !carInventory.hasKey(updatedCar.plate) {
            return {message: "Car not found", success: false};
        }
        
        carInventory[updatedCar.plate] = updatedCar;
        return {
            car: updatedCar,
            message: "Car updated successfully",
            success: true
        };
    }

    # Removes a car from the system
    remote function RemoveCar(PlateRequest request) returns CarList {
        io:println("RemoveCar called for plate: " + request.plate);
        
        _ = carInventory.remove(request.plate);
        
        // Return updated car list
        Car[] cars = [];
        foreach var car in carInventory.values() {
            cars.push(car);
        }
        
        return {cars: cars};
    }

    # Lists all available cars
    remote function ListAvailableCars(FilterRequest filter) returns stream<Car, grpc:Error?> {
        io:println("ListAvailableCars called with filter: " + filter.search_term);
        
        foreach var car in carInventory.values() {
            if car.status == "AVAILABLE" {
                if filter.search_term == "" || 
                   car.make.contains(filter.search_term) || 
                   car.model.contains(filter.search_term) {
                    yield car;
                }
            }
        }
    }

    # Searches for a specific car by plate number
    remote function SearchCar(PlateRequest request) returns CarResponse {
        io:println("SearchCar called for plate: " + request.plate);
        
        if carInventory.hasKey(request.plate) {
            Car car = carInventory[request.plate];
            string availability = car.status == "AVAILABLE" ? "available" : "not available";
            return {
                car: car,
                message: "Car found and is " + availability,
                success: true
            };
        }
        return {message: "Car not found", success: false};
    }

    # Adds a car to the user's rental cart
    remote function AddToCart(CartItem item) returns CartResponse {
        io:println("AddToCart called for plate: " + item.plate + ", user: " + item.username);
        
        if !carInventory.hasKey(item.plate) {
            return {message: "Car not found", success: false};
        }
        
        if !userCarts.hasKey(item.username) {
            userCarts[item.username] = [];
        }
        
        string cartEntry = item.plate + "|" + item.start_date + "|" + item.end_date;
        userCarts[item.username].push(cartEntry);
        
        return {
            message: "Car added to cart successfully",
            success: true
        };
    }

    # Places a reservation for items in the user's cart
    remote function PlaceReservation(ReservationRequest request) returns ReservationResponse {
        io:println("PlaceReservation called for user: " + request.username);
        
        if !userCarts.hasKey(request.username) || userCarts[request.username].length() == 0 {
            return {message: "Cart is empty", success: false};
        }
        
        float totalPrice = 0.0;
        
        foreach string cartItem in userCarts[request.username] {
            string[] parts = cartItem.split("|");
            string plate = parts[0];
            
            if carInventory.hasKey(plate) {
                Car car = carInventory[plate];
                totalPrice += car.daily_price * 3;
            }
        }
        
        userCarts[request.username] = [];
        
        return {
            message: "Reservation placed successfully",
            success: true,
            total_price: totalPrice
        };
    }
}

// Add sample cars when server starts
function addSampleCars() {
    carInventory["ABC123"] = {
        plate: "ABC123",
        make: "Toyota",
        model: "Corolla",
        year: 2022,
        daily_price: 50.0,
        mileage: 15000.0,
        status: "AVAILABLE"
    };
    
    carInventory["XYZ789"] = {
        plate: "XYZ789",
        make: "Honda",
        model: "Civic",
        year: 2023,
        daily_price: 60.0,
        mileage: 8000.0,
        status: "AVAILABLE"
    };
    
    carInventory["DEF456"] = {
        plate: "DEF456",
        make: "Ford",
        model: "Ranger",
        year: 2021,
        daily_price: 70.0,
        mileage: 25000.0,
        status: "UNAVAILABLE"
    };
}

public function main() returns error? {
    addSampleCars();
    io:println("====================================");
    io:println("   CAR RENTAL gRPC SERVER STARTED");
    io:println("====================================");
    io:println("Port: 9090");
    io:println("Sample cars loaded: 3");
    io:println("Server is ready for connections...");
    io:println("====================================");
}