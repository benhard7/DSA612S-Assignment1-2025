import ballerina/grpc;
import ballerina/time;

listener grpc:Listener ep = new (9090);

map<Car> cars = {
    "ABC123":{
        plate_number: "ABC123",
        make: "Toyota",
        model: "Corolla",
        year: 2022,
        daily_price: 50.0,
        mileage: 15000,
        status: "STATUS_AVAILABLE"
    },
    "XYZ789":{
        plate_number: "XYZ789",
        make: "Honda",
        model: "Civic",
        year: 2023,
        daily_price: 60.0,
        mileage: 8000,
        status: "STATUS_AVAILABLE"
    },
    "DEF456":{
        plate_number: "DEF456",
        make: "Ford",
        model: "Ranger",
        year: 2021,
        daily_price: 70.0,
        mileage: 25000,
        status: "STATUS_UNAVAILABLE"
    }
    };
map<User> users = {
    "7782553644": {id: "7782553644",
    name:"Juptor",
    email: "juptor143@gmail.com"}
};
map<CartItem[]> carts = {};
type Reservation record {
    
};

Reservation[] reservations = [];

@grpc:Descriptor {value: CAR_RENTALSYSTEM_DESC}
service "CarRentalService" on ep {

    remote function AddCar(AddCarRequest value) returns AddCarResponse|error {
           string plate = value.car.plate_number;
        cars[plate] = value.car;
        return {
            plate_number: plate,
            message: "Car added successfully",
            success: true
        };
    }

    remote function UpdateCar(UpdateCarRequest value) returns OperationResponse|error {
        if !cars.hasKey(value.plate_number) {
            return { message: "Car not found", success: false };
        }
        Car car = cars[value.plate_number] ?: {};
        if value.make is string { car.make = value.make ?: ""; }
        if value.model is string { car.model = value.model ?: ""; }
        if value.year is int { car.year = value.year ?: 0; }
        if value.daily_price is float { car.daily_price = value.daily_price ?: 0.0; }
        if value.mileage is int { car.mileage = value.mileage ?: 0; }
        if value.status is CarStatus { car.status = value.status ?: "STATUS_UNAVAILABLE"; }
        cars[value.plate_number] = car;
        return { message: "Car updated", success: true };   
    }
    remote function RemoveCar(RemoveCarRequest value) returns OperationResponse|error {
         if !cars.hasKey(value.plate_number) {
            return { message: "Car not found", success: false };
        }
        _ = cars.remove(value.plate_number);
        return { message: "Car removed", success: true };   
    }

    remote function ListAvailableCars(AvailableCarsRequest value) returns ListAvailableCarsResponse|error {
    Car[] result = [];

         int count = 0;
        foreach var [_, car] in cars.entries() {
            if car.status == CarStatus.STATUS_AVAILABLE {
                if value.filter_make is string && car.make != value.filter_make { continue; }
                if value.filter_model is string && car.model != value.filter_model { continue; }
                if value.filter_year is int && car.year != value.filter_year { continue; }

                result.push(car);
                count += 1;
                if value.max_results is int && count >= value.max_results {
                    break;
                }
            }
        }
    }

        
    remote function SearchCar(SearchCarRequest value) returns SearchCarResponse|error {
         if !cars.hasKey(value.plate_number) {
            return { not_found_message: "Car not found" };
        }
        Car car = cars[value.plate_number] ?: {};
        if car.status != CarStatus.STATUS_AVAILABLE {
            return { not_found_message: "Car not available" };
        }
        return { car: car };   
    }

    remote function AddToCart(AddToCartRequest value) returns OperationResponse|error {
        if !cars.hasKey(value.cart_item.plate_number) {
            return { message: "Car not found", success: false };
        }
        if value.cart_item.start_date >= value.cart_item.end_date {
            return { message: "Invalid rental dates", success: false };
        }
        if carts.hasKey(value.user_id) {
            CartItem[] existing = carts[value.user_id] ?:[];
            existing.push(value.cart_item);
            carts[value.user_id] = existing;
        } else {
            carts[value.user_id] = [value.cart_item];
        }
        return { message: "Added to cart", success: true };    
    }

    remote function PlaceReservation(PlaceReservationRequest value) returns ReservationResponse|error {
        CartItem[] items = carts.get(value.user_id);
        float total = 0;
        CartItem[] confirmed = [];

        foreach var item in items {
            if !cars.hasKey(item.plate_number) {
                continue;
            }
            Car car = cars[item.plate_number] ?: {};
            if car.status != CarStatus.STATUS_AVAILABLE {
                continue;
            }
            
            int days  = <int>(time:utcDiffSeconds(item.start_date, item.end_date));
            total += days * car.daily_price;
            car.status = CarStatus.STATUS_UNAVAILABLE;
            cars[item.plate_number] = car;
            confirmed.push(item);
        }
        time:Utc now = time:utcNow();
        
        string  resId = "RES-" + now.toString();
        reservations.push({
            reservation_id: resId,
            user_id: value.user_id,
            total_price: total,
            reserved_items: confirmed,
            message: "Reservation confirmed",
            success: true
        });
        carts[value.user_id] = [];

        return {
            reservation_id: resId,
            message: "Reservation confirmed",
            success: true,
            total_price: total,
            reserved_items: confirmed
        };
    }

    remote function CreateUsers(stream<User> clientStream) returns OperationResponse {
            foreach User user in clientStream  {
            if users[user.id] == user{
                return {message: "User already exist",success: false};
            }
            return { message: "Users created", success: true };
        }
       
    }
    
}

