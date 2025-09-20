import ballerina/grpc;

public const string CAR_RENTAL_DESC = "0A1670726F746F2F6361725F72656E74616C2E70726F746F";

public type Car record {
    string plate_number;
    string make;
    string model;
    int year;
    float daily_price;
    float mileage;
    string status;
};

public type User record {
    string user_id;
    string name;
    string role;
    string email;
};

public type UserSummary record {
    int total_users_created;
    string[] user_ids;
};

public type PlateRequest record {
    string plate_number;
};

public type FilterRequest record {
    string search_term;
    int year;
};

public type CarResponse record {
    Car car?;
    string message;
    boolean success;
};

public type CarList record {
    Car[] cars;
};

public type CartItem record {
    string user_id;
    string plate_number;
    string start_date;
    string end_date;
};

public type CartResponse record {
    boolean success;
    string message;
    float total_price;
};

public type ReservationRequest record {
    string user_id;
};

public type ReservationResponse record {
    boolean success;
    string message;
    string reservation_id;
    float total_amount;
};

public function getDescriptorMapCarRental() returns map<string> {
    return {"car_rental.proto": CAR_RENTAL_DESC};
}

public function getRootDescriptorCarRental() returns string {
    return CAR_RENTAL_DESC;
}