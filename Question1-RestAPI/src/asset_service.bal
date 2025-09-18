import ballerina/http;
import ballerina/time;

// Define types - these are like templates for our data
type Status "ACTIVE"|"UNDER_REPAIR"|"DISPOSED";

type Component record {
    string id;
    string name;
    string description;
};

type MaintenanceSchedule record {
    string scheduleId;
    string frequency; // "QUARTERLY", "YEARLY", etc.
    time:Date nextDueDate;
};

type Task record {
    string taskId;
    string description;
    string status;
};

type WorkOrder record {
    string workOrderId;
    string description;
    string status;
    Task[] tasks;
};

type Asset record {
    string assetTag;
    string name;
    string faculty;
    string department;
    Status status;
    time:Date acquiredDate;
    Component[] components;
    MaintenanceSchedule[] schedules;
    WorkOrder[] workOrders;
};

// Database - this is where we'll store all our assets
final map<Asset> assetDB = {};

// Service definition - this is our main API
service /assets on new http:Listener(9090) {
    // We'll add functions here later
    
    // Example function to get all assets
    resource function get .() returns Asset[] {
        // This will return all assets from our database
        return assetDB.toArray();
    }
}