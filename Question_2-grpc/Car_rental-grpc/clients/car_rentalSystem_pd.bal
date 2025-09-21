import ballerina/grpc;
import ballerina/protobuf;
import ballerina/time;

public const string CAR_RENTALSYSTEM_DESC = "0A166361725F72656E74616C53797374656D2E70726F746F120963617272656E74616C1A1F676F6F676C652F70726F746F6275662F74696D657374616D702E70726F746F22CF010A0343617212210A0C706C6174655F6E756D626572180120012809520B706C6174654E756D62657212120A046D616B6518022001280952046D616B6512140A056D6F64656C18032001280952056D6F64656C12120A0479656172180420012805520479656172121F0A0B6461696C795F7072696365180520012802520A6461696C795072696365122C0A0673746174757318062001280E32142E63617272656E74616C2E436172537461747573520673746174757312180A076D696C6561676518072001280552076D696C6561676522310A0D4164644361725265717565737412200A0363617218012001280B320E2E63617272656E74616C2E436172520363617222670A0E416464436172526573706F6E736512210A0C706C6174655F6E756D626572180120012809520B706C6174654E756D62657212180A076D65737361676518022001280952076D65737361676512180A077375636365737318032001280852077375636365737322BD020A105570646174654361725265717565737412210A0C706C6174655F6E756D626572180120012809520B706C6174654E756D62657212170A046D616B65180220012809480052046D616B6588010112190A056D6F64656C180320012809480152056D6F64656C88010112170A0479656172180420012805480252047965617288010112240A0B6461696C795F70726963651805200128024803520A6461696C795072696365880101121D0A076D696C65616765180620012805480452076D696C6561676588010112310A0673746174757318072001280E32142E63617272656E74616C2E4361725374617475734805520673746174757388010142070A055F6D616B6542080A065F6D6F64656C42070A055F79656172420E0A0C5F6461696C795F7072696365420A0A085F6D696C6561676542090A075F73746174757322350A1052656D6F76654361725265717565737412210A0C706C6174655F6E756D626572180120012809520B706C6174654E756D62657222AF020A14417661696C61626C65436172735265717565737412240A0B66696C7465725F6D616B651801200128094800520A66696C7465724D616B6588010112260A0C66696C7465725F6D6F64656C1802200128094801520B66696C7465724D6F64656C88010112240A0B66696C7465725F796561721803200128054802520A66696C7465725965617288010112240A0B6D61785F726573756C74731804200128054803520A6D6178526573756C747388010112310A0673746174757318052001280E32142E63617272656E74616C2E43617253746174757348045206737461747573880101420E0A0C5F66696C7465725F6D616B65420F0A0D5F66696C7465725F6D6F64656C420E0A0C5F66696C7465725F79656172420E0A0C5F6D61785F726573756C747342090A075F737461747573223D0A194C697374417661696C61626C6543617273526573706F6E736512200A0363617218012003280B320E2E63617272656E74616C2E436172520363617222730A105365617263684361725265717565737412210A0C706C6174655F6E756D626572180120012809520B706C6174654E756D62657212310A0673746174757318022001280E32142E63617272656E74616C2E4361725374617475734800520673746174757388010142090A075F737461747573226F0A11536561726368436172526573706F6E736512220A0363617218012001280B320E2E63617272656E74616C2E43617248005203636172122C0A116E6F745F666F756E645F6D6573736167651802200128094800520F6E6F74466F756E644D65737361676542080A06726573756C74229F010A08436172744974656D12210A0C706C6174655F6E756D626572180120012809520B706C6174654E756D62657212390A0A73746172745F6461746518022001280B321A2E676F6F676C652E70726F746F6275662E54696D657374616D70520973746172744461746512350A08656E645F6461746518032001280B321A2E676F6F676C652E70726F746F6275662E54696D657374616D705207656E6444617465225D0A10416464546F436172745265717565737412170A07757365725F6964180120012809520675736572496412300A09636172745F6974656D18022001280B32132E63617272656E74616C2E436172744974656D5208636172744974656D22600A17506C6163655265736572766174696F6E5265717565737412170A07757365725F69641801200128095206757365724964122C0A0673746174757318022001280E32142E63617272656E74616C2E436172537461747573520673746174757322CD010A135265736572766174696F6E526573706F6E736512250A0E7265736572766174696F6E5F6964180120012809520D7265736572766174696F6E496412180A076D65737361676518022001280952076D65737361676512180A0773756363657373180320012808520773756363657373121F0A0B746F74616C5F7072696365180420012802520A746F74616C5072696365123A0A0E72657365727665645F6974656D7318052003280B32132E63617272656E74616C2E436172744974656D520D72657365727665644974656D7322470A114F7065726174696F6E526573706F6E736512180A077375636365737318012001280852077375636365737312180A076D65737361676518022001280952076D65737361676522400A0455736572120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512140A05656D61696C1803200128095205656D61696C2A510A0943617253746174757312160A125354415455535F554E535045434946494544100012140A105354415455535F415641494C41424C45100112160A125354415455535F554E415641494C41424C45100232E5040A1043617252656E74616C53657276696365123D0A0641646443617212182E63617272656E74616C2E416464436172526571756573741A192E63617272656E74616C2E416464436172526573706F6E736512460A09557064617465436172121B2E63617272656E74616C2E557064617465436172526571756573741A1C2E63617272656E74616C2E4F7065726174696F6E526573706F6E736512460A0952656D6F7665436172121B2E63617272656E74616C2E52656D6F7665436172526571756573741A1C2E63617272656E74616C2E4F7065726174696F6E526573706F6E7365125A0A114C697374417661696C61626C6543617273121F2E63617272656E74616C2E417661696C61626C6543617273526571756573741A242E63617272656E74616C2E4C697374417661696C61626C6543617273526573706F6E736512460A09536561726368436172121B2E63617272656E74616C2E536561726368436172526571756573741A1C2E63617272656E74616C2E536561726368436172526573706F6E736512460A09416464546F43617274121B2E63617272656E74616C2E416464546F43617274526571756573741A1C2E63617272656E74616C2E4F7065726174696F6E526573706F6E736512560A10506C6163655265736572766174696F6E12222E63617272656E74616C2E506C6163655265736572766174696F6E526571756573741A1E2E63617272656E74616C2E5265736572766174696F6E526573706F6E7365123E0A0B4372656174655573657273120F2E63617272656E74616C2E557365721A1C2E63617272656E74616C2E4F7065726174696F6E526573706F6E73652801620670726F746F33";

public isolated client class CarRentalServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, CAR_RENTALSYSTEM_DESC);
    }

    isolated remote function AddCar(AddCarRequest|ContextAddCarRequest req) returns AddCarResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddCarRequest message;
        if req is ContextAddCarRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/AddCar", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddCarResponse>result;
    }

    isolated remote function AddCarContext(AddCarRequest|ContextAddCarRequest req) returns ContextAddCarResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddCarRequest message;
        if req is ContextAddCarRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/AddCar", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddCarResponse>result, headers: respHeaders};
    }

    isolated remote function UpdateCar(UpdateCarRequest|ContextUpdateCarRequest req) returns OperationResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateCarRequest message;
        if req is ContextUpdateCarRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/UpdateCar", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OperationResponse>result;
    }

    isolated remote function UpdateCarContext(UpdateCarRequest|ContextUpdateCarRequest req) returns ContextOperationResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateCarRequest message;
        if req is ContextUpdateCarRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/UpdateCar", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OperationResponse>result, headers: respHeaders};
    }

    isolated remote function RemoveCar(RemoveCarRequest|ContextRemoveCarRequest req) returns OperationResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveCarRequest message;
        if req is ContextRemoveCarRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/RemoveCar", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OperationResponse>result;
    }

    isolated remote function RemoveCarContext(RemoveCarRequest|ContextRemoveCarRequest req) returns ContextOperationResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveCarRequest message;
        if req is ContextRemoveCarRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/RemoveCar", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OperationResponse>result, headers: respHeaders};
    }

    isolated remote function ListAvailableCars(AvailableCarsRequest|ContextAvailableCarsRequest req) returns ListAvailableCarsResponse|grpc:Error {
        map<string|string[]> headers = {};
        AvailableCarsRequest message;
        if req is ContextAvailableCarsRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/ListAvailableCars", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListAvailableCarsResponse>result;
    }

    isolated remote function ListAvailableCarsContext(AvailableCarsRequest|ContextAvailableCarsRequest req) returns ContextListAvailableCarsResponse|grpc:Error {
        map<string|string[]> headers = {};
        AvailableCarsRequest message;
        if req is ContextAvailableCarsRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/ListAvailableCars", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListAvailableCarsResponse>result, headers: respHeaders};
    }

    isolated remote function SearchCar(SearchCarRequest|ContextSearchCarRequest req) returns SearchCarResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchCarRequest message;
        if req is ContextSearchCarRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/SearchCar", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SearchCarResponse>result;
    }

    isolated remote function SearchCarContext(SearchCarRequest|ContextSearchCarRequest req) returns ContextSearchCarResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchCarRequest message;
        if req is ContextSearchCarRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/SearchCar", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SearchCarResponse>result, headers: respHeaders};
    }

    isolated remote function AddToCart(AddToCartRequest|ContextAddToCartRequest req) returns OperationResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OperationResponse>result;
    }

    isolated remote function AddToCartContext(AddToCartRequest|ContextAddToCartRequest req) returns ContextOperationResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OperationResponse>result, headers: respHeaders};
    }

    isolated remote function PlaceReservation(PlaceReservationRequest|ContextPlaceReservationRequest req) returns ReservationResponse|grpc:Error {
        map<string|string[]> headers = {};
        PlaceReservationRequest message;
        if req is ContextPlaceReservationRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/PlaceReservation", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ReservationResponse>result;
    }

    isolated remote function PlaceReservationContext(PlaceReservationRequest|ContextPlaceReservationRequest req) returns ContextReservationResponse|grpc:Error {
        map<string|string[]> headers = {};
        PlaceReservationRequest message;
        if req is ContextPlaceReservationRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.CarRentalService/PlaceReservation", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ReservationResponse>result, headers: respHeaders};
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("carrental.CarRentalService/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public isolated client class CreateUsersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveOperationResponse() returns OperationResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <OperationResponse>payload;
        }
    }

    isolated remote function receiveContextOperationResponse() returns ContextOperationResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <OperationResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextReservationResponse record {|
    ReservationResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableCarsResponse record {|
    ListAvailableCarsResponse content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextRemoveCarRequest record {|
    RemoveCarRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateCarRequest record {|
    UpdateCarRequest content;
    map<string|string[]> headers;
|};

public type ContextAddCarResponse record {|
    AddCarResponse content;
    map<string|string[]> headers;
|};

public type ContextAddToCartRequest record {|
    AddToCartRequest content;
    map<string|string[]> headers;
|};

public type ContextSearchCarRequest record {|
    SearchCarRequest content;
    map<string|string[]> headers;
|};

public type ContextAddCarRequest record {|
    AddCarRequest content;
    map<string|string[]> headers;
|};

public type ContextPlaceReservationRequest record {|
    PlaceReservationRequest content;
    map<string|string[]> headers;
|};

public type ContextSearchCarResponse record {|
    SearchCarResponse content;
    map<string|string[]> headers;
|};

public type ContextOperationResponse record {|
    OperationResponse content;
    map<string|string[]> headers;
|};

public type ContextAvailableCarsRequest record {|
    AvailableCarsRequest content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type ReservationResponse record {|
    string reservation_id = "";
    string message = "";
    boolean success = false;
    float total_price = 0.0;
    CartItem[] reserved_items = [];
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type ListAvailableCarsResponse record {|
    Car[] car = [];
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type User record {|
    string id = "";
    string name = "";
    string email = "";
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type RemoveCarRequest record {|
    string plate_number = "";
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type UpdateCarRequest record {|
    string plate_number = "";
    float daily_price?;
    string make?;
    string model?;
    CarStatus status?;
    int mileage?;
    int year?;
|};

isolated function isValidUpdatecarrequest(UpdateCarRequest r) returns boolean {
    int _daily_priceCount = 0;
    if r?.daily_price !is () {
        _daily_priceCount += 1;
    }
    int _makeCount = 0;
    if r?.make !is () {
        _makeCount += 1;
    }
    int _modelCount = 0;
    if r?.model !is () {
        _modelCount += 1;
    }
    int _statusCount = 0;
    if r?.status !is () {
        _statusCount += 1;
    }
    int _mileageCount = 0;
    if r?.mileage !is () {
        _mileageCount += 1;
    }
    int _yearCount = 0;
    if r?.year !is () {
        _yearCount += 1;
    }
    if _daily_priceCount > 1 || _makeCount > 1 || _modelCount > 1 || _statusCount > 1 || _mileageCount > 1 || _yearCount > 1 {
        return false;
    }
    return true;
}

isolated function setUpdateCarRequest_DailyPrice(UpdateCarRequest r, float daily_price) {
    r.daily_price = daily_price;
}

isolated function setUpdateCarRequest_Make(UpdateCarRequest r, string make) {
    r.make = make;
}

isolated function setUpdateCarRequest_Model(UpdateCarRequest r, string model) {
    r.model = model;
}

isolated function setUpdateCarRequest_Status(UpdateCarRequest r, CarStatus status) {
    r.status = status;
}

isolated function setUpdateCarRequest_Mileage(UpdateCarRequest r, int mileage) {
    r.mileage = mileage;
}

isolated function setUpdateCarRequest_Year(UpdateCarRequest r, int year) {
    r.year = year;
}

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type AddCarResponse record {|
    string plate_number = "";
    string message = "";
    boolean success = false;
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type CartItem record {|
    string plate_number = "";
    time:Utc start_date = [0, 0.0d];
    time:Utc end_date = [0, 0.0d];
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type AddToCartRequest record {|
    string user_id = "";
    CartItem cart_item = {};
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type SearchCarRequest record {|
    string plate_number = "";
    CarStatus status?;
|};

isolated function isValidSearchcarrequest(SearchCarRequest r) returns boolean {
    int _statusCount = 0;
    if r?.status !is () {
        _statusCount += 1;
    }
    if _statusCount > 1 {
        return false;
    }
    return true;
}

isolated function setSearchCarRequest_Status(SearchCarRequest r, CarStatus status) {
    r.status = status;
}

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type AddCarRequest record {|
    Car car = {};
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type Car record {|
    string plate_number = "";
    string make = "";
    string model = "";
    int year = 0;
    float daily_price = 0.0;
    CarStatus status = STATUS_UNSPECIFIED;
    int mileage = 0;
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type PlaceReservationRequest record {|
    string user_id = "";
    CarStatus status = STATUS_UNSPECIFIED;
|};

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type SearchCarResponse record {|
    Car car?;
    string not_found_message?;
|};

isolated function isValidSearchcarresponse(SearchCarResponse r) returns boolean {
    int resultCount = 0;
    if r?.car !is () {
        resultCount += 1;
    }
    if r?.not_found_message !is () {
        resultCount += 1;
    }
    if resultCount > 1 {
        return false;
    }
    return true;
}

isolated function setSearchCarResponse_Car(SearchCarResponse r, Car car) {
    r.car = car;
    _ = r.removeIfHasKey("not_found_message");
}

isolated function setSearchCarResponse_NotFoundMessage(SearchCarResponse r, string not_found_message) {
    r.not_found_message = not_found_message;
    _ = r.removeIfHasKey("car");
}

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type AvailableCarsRequest record {|
    string filter_model?;
    int max_results?;
    int filter_year?;
    string filter_make?;
    CarStatus status?;
|};

isolated function isValidAvailablecarsrequest(AvailableCarsRequest r) returns boolean {
    int _filter_modelCount = 0;
    if r?.filter_model !is () {
        _filter_modelCount += 1;
    }
    int _max_resultsCount = 0;
    if r?.max_results !is () {
        _max_resultsCount += 1;
    }
    int _filter_yearCount = 0;
    if r?.filter_year !is () {
        _filter_yearCount += 1;
    }
    int _filter_makeCount = 0;
    if r?.filter_make !is () {
        _filter_makeCount += 1;
    }
    int _statusCount = 0;
    if r?.status !is () {
        _statusCount += 1;
    }
    if _filter_modelCount > 1 || _max_resultsCount > 1 || _filter_yearCount > 1 || _filter_makeCount > 1 || _statusCount > 1 {
        return false;
    }
    return true;
}

isolated function setAvailableCarsRequest_FilterModel(AvailableCarsRequest r, string filter_model) {
    r.filter_model = filter_model;
}

isolated function setAvailableCarsRequest_MaxResults(AvailableCarsRequest r, int max_results) {
    r.max_results = max_results;
}

isolated function setAvailableCarsRequest_FilterYear(AvailableCarsRequest r, int filter_year) {
    r.filter_year = filter_year;
}

isolated function setAvailableCarsRequest_FilterMake(AvailableCarsRequest r, string filter_make) {
    r.filter_make = filter_make;
}

isolated function setAvailableCarsRequest_Status(AvailableCarsRequest r, CarStatus status) {
    r.status = status;
}

@protobuf:Descriptor {value: CAR_RENTALSYSTEM_DESC}
public type OperationResponse record {|
    boolean success = false;
    string message = "";
|};

public enum CarStatus {
    STATUS_UNSPECIFIED, STATUS_AVAILABLE, STATUS_UNAVAILABLE
}
