import ballerina/grpc;
import ballerina/protobuf;

public const string CAR_RENTAL_DESC = "0A1670726F746F2F6361725F72656E74616C2E70726F746F120A6361725F72656E74616C228B010A0343617212210A0C706C6174655F6E756D626572180120012809520B706C6174654E756D62657212120A046D616B6518022001280952046D616B6512140A056D6F64656C18032001280952056D6F64656C121F0A0B6461696C795F7072696365180420012801520A6461696C79507269636512160A067374617475731805200128095206737461747573222F0A0A4361725265717565737412210A0C706C6174655F6E756D626572180120012809520B706C6174654E756D62657232740A1043617252656E74616C53657276696365122A0A06416464436172120F2E6361725F72656E74616C2E4361721A0F2E6361725F72656E74616C2E43617212340A0953656172636843617212162E6361725F72656E74616C2E436172526571756573741A0F2E6361725F72656E74616C2E436172620670726F746F33";

public isolated client class CarRentalServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, CAR_RENTAL_DESC);
    }

    isolated remote function AddCar(Car|ContextCar req) returns Car|grpc:Error {
        map<string|string[]> headers = {};
        Car message;
        if req is ContextCar {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("car_rental.CarRentalService/AddCar", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Car>result;
    }

    isolated remote function AddCarContext(Car|ContextCar req) returns ContextCar|grpc:Error {
        map<string|string[]> headers = {};
        Car message;
        if req is ContextCar {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("car_rental.CarRentalService/AddCar", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Car>result, headers: respHeaders};
    }

    isolated remote function SearchCar(CarRequest|ContextCarRequest req) returns Car|grpc:Error {
        map<string|string[]> headers = {};
        CarRequest message;
        if req is ContextCarRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("car_rental.CarRentalService/SearchCar", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Car>result;
    }

    isolated remote function SearchCarContext(CarRequest|ContextCarRequest req) returns ContextCar|grpc:Error {
        map<string|string[]> headers = {};
        CarRequest message;
        if req is ContextCarRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("car_rental.CarRentalService/SearchCar", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Car>result, headers: respHeaders};
    }
}

public isolated client class CarRentalServiceCarCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCar(Car response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCar(ContextCar response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextCar record {|
    Car content;
    map<string|string[]> headers;
|};

public type ContextCarRequest record {|
    CarRequest content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: CAR_RENTAL_DESC}
public type Car record {|
    string plate_number = "";
    string make = "";
    string model = "";
    float daily_price = 0.0;
    string status = "";
|};

@protobuf:Descriptor {value: CAR_RENTAL_DESC}
public type CarRequest record {|
    string plate_number = "";
|};
