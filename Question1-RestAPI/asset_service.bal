import ballerina/http;
import ballerina/time;

// Define types
type Status "ACTIVE"|"UNDER_REPAIR"|"DISPOSED";

type Component record {
    string id;
    string name;
    string description;
};

type MaintenanceSchedule record {
    string scheduleId;
    string frequency;
    time:Date nextDueDate;
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
};

// Database
final map<Asset> assetDB = {};

// Service definition
service /assets on new http:Listener(9090) {
    
    // Simple test endpoint
    resource function get .() returns string {
        return "✅ Asset Management API is working!";
    }
}