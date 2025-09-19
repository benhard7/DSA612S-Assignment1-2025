// gen/car_rental_client.bal
import ballerina/grpc;

public isolated client class CarRentalClient {
    final grpc:Client grpcClient;

    public isolated function init(string url, grpc:ClientConfiguration? config = ()) returns error? {
        self.grpcClient = check new (url, config);
    }

    // Admin operations
    remote isolated function AddCar(car_rental_pb:AddCarRequest request) returns car_rental_pb:AddCarResponse|error {
        return self.grpcClient->remoteCall("carrental.CarRentalService/AddCar", request, car_rental_pb:AddCarResponse);
    }

    remote isolated function UpdateCar(car_rental_pb:UpdateCarRequest request) returns car_rental_pb:OperationResponse|error {
        return self.grpcClient->remoteCall("carrental.CarRentalService/UpdateCar", request, car_rental_pb:OperationResponse);
    }

    remote isolated function RemoveCar(car_rental_pb:RemoveCarRequest request) returns stream<car_rental_pb:Car, error?>|error {
        return self.grpcClient->remoteStreamCall("carrental.CarRentalService/RemoveCar", request, car_rental_pb:Car);
    }

    // User management
    remote isolated function CreateUsers(stream<car_rental_pb:User> request) returns car_rental_pb:OperationResponse|error {
        return self.grpcClient->remoteCall("carrental.CarRentalService/CreateUsers", request, car_rental_pb:OperationResponse);
    }

    // Customer operations
    remote isolated function ListAvailableCars(car_rental_pb:AvailableCarsRequest request) returns stream<car_rental_pb:Car, error?>|error {
        return self.grpcClient->remoteStreamCall("carrental.CarRentalService/ListAvailableCars", request, car_rental_pb:Car);
    }

    remote isolated function SearchCar(car_rental_pb:SearchCarRequest request) returns car_rental_pb:SearchCarResponse|error {
        return self.grpcClient->remoteCall("carrental.CarRentalService/SearchCar", request, car_rental_pb:SearchCarResponse);
    }

    remote isolated function AddToCart(car_rental_pb:AddToCartRequest request) returns car_rental_pb:OperationResponse|error {
        return self.grpcClient->remoteCall("carrental.CarRentalService/AddToCart", request, car_rental_pb:OperationResponse);
    }

    remote isolated function PlaceReservation(car_rental_pb:PlaceReservationRequest request) returns car_rental_pb:ReservationResponse|error {
        return self.grpcClient->remoteCall("carrental.CarRentalService/PlaceReservation", request, car_rental_pb:ReservationResponse);
    }
}