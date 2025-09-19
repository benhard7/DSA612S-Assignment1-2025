// gen/car_rental_service.bal
import ballerina/grpc;

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR_CAR_RENTAL, descMap: getDescriptorMapCarRental()} 
service "CarRentalService" on class CarRentalService {

}

public isolated class CarRentalService {
    *grpc:Service;

    // Admin operations
    remote isolated function AddCar(car_rental_pb:AddCarRequest value) returns car_rental_pb:AddCarResponse|error {
        return error("Not implemented");
    }

    remote isolated function UpdateCar(car_rental_pb:UpdateCarRequest value) returns car_rental_pb:OperationResponse|error {
        return error("Not implemented");
    }

    remote isolated function RemoveCar(car_rental_pb:RemoveCarRequest value) returns stream<car_rental_pb:Car, error?>|error {
        return error("Not implemented");
    }

    // User management
    remote isolated function CreateUsers(stream<car_rental_pb:User> value) returns car_rental_pb:OperationResponse|error {
        return error("Not implemented");
    }

    // Customer operations
    remote isolated function ListAvailableCars(car_rental_pb:AvailableCarsRequest value) returns stream<car_rental_pb:Car, error?>|error {
        return error("Not implemented");
    }

    remote isolated function SearchCar(car_rental_pb:SearchCarRequest value) returns car_rental_pb:SearchCarResponse|error {
        return error("Not implemented");
    }

    remote isolated function AddToCart(car_rental_pb:AddToCartRequest value) returns car_rental_pb:OperationResponse|error {
        return error("Not implemented");
    }

    remote isolated function PlaceReservation(car_rental_pb:PlaceReservationRequest value) returns car_rental_pb:ReservationResponse|error {
        return error("Not implemented");
    }
}