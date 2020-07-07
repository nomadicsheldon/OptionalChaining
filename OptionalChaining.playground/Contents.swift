import UIKit

/*
 class Person {
 var residence: Residence?
 }
 
 class Residence {
 var numberOfRooms = 1
 }
 
 let john = Person()
 
 // it will crash here -
 //let roomCount = john.residence!.numberOfRooms
 //print(roomCount)
 
 if let roomCount = john.residence?.numberOfRooms {
 print("John's residence has \(roomCount) room(s).")
 } else {
 print("Unable to retrieve the number of rooms.")
 }
 
 john.residence = Residence()
 
 let roomCount = john.residence!.numberOfRooms
 print(roomCount)
 
 if let roomCount = john.residence?.numberOfRooms {
 print("John's residence has \(roomCount) room(s).")
 } else {
 print("Unable to retrieve the number of rooms.")
 }
 
 */

//-----------------------------------------------------------------------------------//

// Defining Model Classes for Optional Chaining

class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

// Accessing property through optional chaining

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "HSR"
john.residence?.address = someAddress // It will fail because john.residence is currently nil.

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "HSR"
    return someAddress
}

john.residence?.address = createAddress()

// Calling method through optional chaining

if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}

// Accessing Subscripts through optional chaining

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name.")
}

john.residence?[0] = Room(name: "Bathroom") // it will fail

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name.")
}

// Accessing Subscripts of Optional Type

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72

// Linking multiple levels of chaining

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet)")
} else {
    print("Unable to retrieve the address.")
}

// chaining on Methods with Optional Return Values

if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building indentifier is \(buildingIdentifier).")
}

if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begins with \"The\".")
    }
}
