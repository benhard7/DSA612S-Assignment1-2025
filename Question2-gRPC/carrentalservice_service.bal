import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: CAR_RENTAL_DESC}
service "CarRentalService" on ep {

    remote function AddCar(Car value) returns Car|error {
    }

    remote function SearchCar(CarRequest value) returns Car|error {
    }
}
