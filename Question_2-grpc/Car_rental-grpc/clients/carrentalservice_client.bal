import ballerina/io;

CarRentalServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    AddCarRequest addCarRequest = {car: {plate_number: "NA17W", make: "FORD", model: "ranger", year: 2016, daily_price: 300000, status: "STATUS_UNSPECIFIED"}};
    AddCarResponse addCarResponse = check ep->AddCar(addCarRequest);
    io:println(addCarResponse);


    UpdateCarRequest updateCarRequest = {plate_number: "ABC123"};
    OperationResponse updateCarResponse = check ep->UpdateCar(updateCarRequest);
    io:println(updateCarResponse);

    RemoveCarRequest removeCarRequest = {plate_number: "DEF456"};
    OperationResponse removeCarResponse = check ep->RemoveCar(removeCarRequest);
    io:println(removeCarResponse);

    AvailableCarsRequest listAvailableCarsRequest = {};
    ListAvailableCarsResponse listAvailableCarsResponse = check ep->ListAvailableCars(listAvailableCarsRequest);
    io:println(listAvailableCarsResponse);

    SearchCarRequest searchCarRequest = {plate_number:  "NA15W"};
    SearchCarResponse searchCarResponse = check ep->SearchCar(searchCarRequest);
    io:println(searchCarResponse);

    AddToCartRequest addToCartRequest = {user_id: "2551963804", cart_item: {plate_number: "NA17W", start_date: [1659688553, 0.310073000d], end_date: [1659688553, 0.310073000d]}};
    OperationResponse addToCartResponse = check ep->AddToCart(addToCartRequest);
    io:println(addToCartResponse);

    PlaceReservationRequest placeReservationRequest = {user_id: "2551963804", status: "STATUS_UNSPECIFIED"};
    ReservationResponse placeReservationResponse = check ep->PlaceReservation(placeReservationRequest);
    io:println(placeReservationResponse);

    User createUsersRequest = {id: "772025192", name: "skyie", email: "ballerina@gmail.com"};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->CreateUsers();
    check createUsersStreamingClient->sendUser(createUsersRequest);
    check createUsersStreamingClient->complete();
    OperationResponse? createUsersResponse = check createUsersStreamingClient->receiveOperationResponse();
    io:println(createUsersResponse);
}
