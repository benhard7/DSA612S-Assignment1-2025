import ballerina/grpc;

@grpc:ServiceDescriptor {
    descriptor: getRootDescriptorCarRental(),
    descMap: getDescriptorMapCarRental()
}
public service class CarRentalService {
    *grpc:Service;
    
    remote function AddCar(Car car) returns CarResponse {
        return {success: false, message: "Not implemented"};
    }
    
    remote function CreateUsers(stream<User, grpc:Error?> userStream) returns UserSummary|error {
        return {total_users_created: 0, user_ids: []};
    }
    
    remote function UpdateCar(Car car) returns CarResponse {
        return {success: false, message: "Not implemented"};
    }
    
    remote function RemoveCar(PlateRequest request) returns CarList {
        return {cars: []};
    }
    
    remote function ListAvailableCars(FilterRequest request) returns stream<Car, grpc:Error?> {
        return [];
    }
    
    remote function SearchCar(PlateRequest request) returns CarResponse {
        return {success: false, message: "Not implemented"};
    }
    
    remote function AddToCart(CartItem item) returns CartResponse {
        return {success: false, message: "Not implemented", total_price: 0.0};
    }
    
    remote function PlaceReservation(ReservationRequest request) returns ReservationResponse {
        return {success: false, message: "Not implemented", reservation_id: "", total_amount: 0.0};
    }
}