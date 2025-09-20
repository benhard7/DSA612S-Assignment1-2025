import ballerina/grpc;

public client class CarRentalServiceClient {
    final grpc:Client grpcClient;
    
    public function init(string url) returns grpc:Error? {
        self.grpcClient = check new (url);
    }
    
    remote function AddCar(Car car) returns CarResponse|grpc:Error {
        return self.grpcClient->AddCar(car);
    }
    
    remote function CreateUsers(stream<User, grpc:Error?> userStream) returns UserSummary|grpc:Error {
        return self.grpcClient->CreateUsers(userStream);
    }
    
    remote function UpdateCar(Car car) returns CarResponse|grpc:Error {
        return self.grpcClient->UpdateCar(car);
    }
    
    remote function RemoveCar(PlateRequest request) returns CarList|grpc:Error {
        return self.grpcClient->RemoveCar(request);
    }
    
    remote function ListAvailableCars(FilterRequest request) returns stream<Car, grpc:Error?>|grpc:Error {
        return self.grpcClient->ListAvailableCars(request);
    }
    
    remote function SearchCar(PlateRequest request) returns CarResponse|grpc:Error {
        return self.grpcClient->SearchCar(request);
    }
    
    remote function AddToCart(CartItem item) returns CartResponse|grpc:Error {
        return self.grpcClient->AddToCart(item);
    }
    
    remote function PlaceReservation(ReservationRequest request) returns ReservationResponse|grpc:Error {
        return self.grpcClient->PlaceReservation(request);
    }
}