import ballerina/http;

// Simple working API to start with
service /assets on new http:Listener(9090) {
    
    resource function get .() returns string {
        return "✅ Asset Management API is working!";
    }
    
    resource function post .(@http:Payload string payload) returns string {
        return "Received: " + payload;
    }
}