import UIKit

class MbaClass {
    var name: String
    //spots should be an Int with the real data
    var spotsAvailable: String
    
    init(name: String, spotsAvailable: String) {
        self.name = name
        self.spotsAvailable = spotsAvailable
    }
}

class Date {
    // exactDate should eventually be passed into a DateFormatter()
    var exactDate: String
    var classes: [MbaClass]
    
    init(exactDate: String, classes: [MbaClass]) {
        self.exactDate = exactDate
        self.classes = classes
    }
}

var data = ["class-date-row1", "class-name1", "num-slots-available-container1", "class-description-row1", "class-name2", "num-slots-available-container2", "class-description-row2", "class-name3", "num-slots-available-container3", "class-description-row3", "class-date-row2", "class-name4", "num-slots-available-container4", "class-description-row4", "class-name5", "num-slots-available-container5", "class-description-row5", "class-name6", "num-slots-available-container6", "class-description-row6"]

let totalValues = data.count
var dateArray = [Date]()
for (index, item) in data.enumerated() {
    if item.starts(with: "class-date") {
        let date = Date(exactDate: data[index], classes: [MbaClass(name: data[index+1], spotsAvailable: data[index+2])])
        dateArray.append(date)
    } else if item.starts(with: "class-name") && (data[index-1].starts(with: "class-date") == false) {
        let boxingClass = MbaClass(name: item, spotsAvailable: data[index+1])
        if var previousDate = dateArray.last {
            previousDate.classes.append(boxingClass)
        }
    }
}

dateArray[0].classes.count
for item in dateArray[0].classes {
    print(item.name)
}
// Need a loop that creates a date object with the first item, then for each arraySlice of 3 items creats a MbaClass (after the first item that is the date itself, use the next two to create the class and discard the third) and then appends each class to that date's classes array
