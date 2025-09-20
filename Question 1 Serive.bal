import ballerina/http;

// ===== Data types =====
type Task record {|
    string name;
    string status; // e.g. PENDING, DONE
|};

type WorkOrder record {|
    string id;
    string description;
    string status; // OPEN, IN_PROGRESS, CLOSED
    Task[] tasks;
|};

type Schedule record {|
    string name;
    string dueDate; // YYYY-MM-DD
|};

type Asset record {|
    string assetTag;
    string name;
    string faculty;
    string department;
    string status;
    string acquiredDate;
    map<string> components;
    Schedule[] schedules;
    WorkOrder[] workOrders;
|};

// ===== "Database" =====
map<Asset> assets = {};

// ===== Helper: crude overdue check (manual current date) =====
function isOverdue(string dueDate) returns boolean {
    // Simple string comparison (works because YYYY-MM-DD format is lexically sortable)
    string currentDate = "2025-09-20"; // Fixed current date as per assignment
    
    // If due date is earlier than current date, it's overdue
    return dueDate < currentDate;
}

// ===== Service =====
service /assets on new http:Listener(8080) {

    // Create asset
    resource function post .(Asset asset) returns string {
        assets[asset.assetTag] = asset;
        return "✅ Asset " + asset.assetTag + " created!";
    }

    // Get all
    resource function get .() returns map<Asset> {
        return assets;
    }

    // Get one
    resource function get [string id]() returns Asset|error {
        Asset? a = assets[id];
        if a is Asset {
            return a;
        }
        return error("Not found");
    }

    // Update
    resource function put [string id](Asset updated) returns string|error {
        if assets.hasKey(id) {
            assets[id] = updated;
            return "Updated!";
        }
        return error("Not found");
    }

    // Delete
    resource function delete [string id]() returns string|error {
        if assets.hasKey(id) {
            _ = assets.remove(id);
            return "Deleted!";
        }
        return error("Not found");
    }

    // Filter by faculty
    resource function get faculty/[string fac]() returns Asset[] {
        Asset[] res = [];
        foreach var [_, a] in assets.entries() {
            if a.faculty.toLowerAscii() == fac.toLowerAscii() {
                res.push(a);
            }
        }
        return res;
    }

    // Overdue check
    resource function get overdue() returns Asset[] {
        Asset[] res = [];
        foreach var [_, a] in assets.entries() {
            foreach var s in a.schedules {
                if isOverdue(s.dueDate) {
                    res.push(a);
                    break;
                }
            }
        }
        return res;
    }

    // Add component
    resource function post [string id]/components(string key, string val) returns string|error {
        Asset? a = assets[id];
        if a is Asset {
            a.components[key] = val;
            assets[id] = a;
            return "Component added!";
        }
        return error("Not found");
    }

    // Remove component
    resource function delete [string id]/components/[string key]() returns string|error {
        Asset? a = assets[id];
        if a is Asset {
            _ = a.components.remove(key);
            assets[id] = a;
            return "Component removed!";
        }
        return error("Not found");
    }

    // Add schedule
    resource function post [string id]/schedules(Schedule s) returns string|error {
        Asset? a = assets[id];
        if a is Asset {
            a.schedules.push(s);
            assets[id] = a;
            return "Schedule added!";
        }
        return error("Not found");
    }

    // Add work order
    resource function post [string id]/workorders(WorkOrder w) returns string|error {
        Asset? a = assets[id];
        if a is Asset {
            a.workOrders.push(w);
            assets[id] = a;
            return "Work order added!";
        }
        return error("Not found");
    }

    // Add task
    resource function post [string id]/workorders/[string wid]/tasks(Task t) returns string|error {
        Asset? a = assets[id];
        if a is Asset {
            foreach int i in 0..<a.workOrders.length() {
                if a.workOrders[i].id == wid {
                    a.workOrders[i].tasks.push(t);
                    assets[id] = a;
                    return "Task added!";
                }
            }
            return error("Work order not found");
        }
        return error("Asset not found");
    }
}
