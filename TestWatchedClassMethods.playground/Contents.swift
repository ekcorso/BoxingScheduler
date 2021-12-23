import UIKit

// ClASSES etc
class MbaClass: NSObject, NSCoding {
    // name could have an enum
    var name: String = ""
    var spotsAvailable: Int = 0
    var date: Date = Date()
    var time: String = ""
    
    init(name: String, spotsAvailable: String, date: String) {
        super.init()
        let fullDate = date + " \(getStartTime(for: name))"
        self.name = name
        self.spotsAvailable = getSpotsAsInt(from: spotsAvailable)
        self.date = fullDate.toDate() ?? Date()
    }
    
    required init?(coder: NSCoder) {
        guard let name = coder.decodeObject(forKey: "name") as? String else {
            print("decoding name failed in init")
            return nil
        }
        guard let date = coder.decodeObject(forKey: "date") as? Date else {
            print("decoding date failed in init")
            return nil
        }
        guard let time = coder.decodeObject(forKey: "time") as? String else {
            print("decoding time failed in init")
            return nil
        }
        
        spotsAvailable = coder.decodeInteger(forKey: "spotsAvailable")
        self.name = name
        self.date = date
        self.time = time
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.spotsAvailable, forKey: "spotsAvailable")
        coder.encode(self.date, forKey: "date")
        coder.encode(self.time, forKey: "time")
    }
    
    private func getSpotsAsInt(from spotsString: String) -> Int {
        var spotsInt: Int = 0
        if let num = Int(spotsString.components(separatedBy: .decimalDigits.inverted).joined()) {
            spotsInt = num
        }
        return spotsInt
    }
    
    private func getStartTime(for className: String) -> String {
        // Rather than eleaborate parsing, use the ClassType enum and give them associated values, then just switch over those returning the appropriate time. Pros: more readable. Cons: more brittle, less "cool"
        switch className {
        case ClassType.morningBodyBlastMondays.rawValue:
            return "06:30"
        case ClassType.footworkFundamentalsMondays.rawValue:
            return "17:00"
        case ClassType.lunchTimeBoxingPowerHourTuesdays.rawValue:
            return "12:00"
        case ClassType.cardioBoxingTuesdays5.rawValue:
            return "17:00"
        case ClassType.cardioBoxingTuesdays615.rawValue:
            return "18:15"
        case ClassType.boxingSkillsTuesdays.rawValue:
            return "19:15"
        case ClassType.morningBodyBlastWednesdays.rawValue:
            return "06:30"
        case ClassType.combatConditioningWednesdays.rawValue:
            return "17:00"
        case ClassType.TeamPracticeWednesdays.rawValue:
            return "18:00"
        case ClassType.lunchTimeBoxingPowerHourThursdays.rawValue:
            return "12:00"
        case ClassType.cardioBoxingThursdays5.rawValue:
            return "17:00"
        case ClassType.cardioBoxingThursdays615.rawValue:
            return "18:15"
        case ClassType.boxingSkillsThursdays.rawValue:
            return "19:15"
        case ClassType.morningBodyBlastFridays.rawValue:
            return "06:30"
        case ClassType.combatConditioningFridays.rawValue:
            return "17:00"
        case ClassType.teamPracticeFridays.rawValue:
            return "18:00"
        case ClassType.cardioBoxingSaturdays9.rawValue:
            return "09:00"
        case ClassType.cardioBoxingSaturdays1030.rawValue:
            return "10:15"
        default:
            return "12:00"
        }
    }
}

enum ClassType: String {
    //give raw values that are strings for the class names, then create an getStartTime() func that switches over these are returns a time for each (time should be formatted with the dateFormatter eventually, but could be a string to start)
    case morningBodyBlastMondays = "Morning Body Blast Mondays (With Permission Only)"
    case footworkFundamentalsMondays = "Footwork FUNdamentals Mondays (With Permission Only)"
    case lunchTimeBoxingPowerHourTuesdays = "Lunch-Time Boxing Power Hour Tuesdays"
    case cardioBoxingTuesdays5 = "Cardio Boxing Tuesdays (5pm)"
    case cardioBoxingTuesdays615 = "Cardio Boxing Tuesdays (6:15pm)"
    case boxingSkillsTuesdays = "Boxing Skills Tuesdays (With Permission Only)"
    case morningBodyBlastWednesdays = "Morning Body Blast Wednesdays (With Permission Only)"
    case combatConditioningWednesdays = "Combat Conditioning Wednesdays"
    case TeamPracticeWednesdays = "Team Practice Wednesdays (With Permission Only)"
    case lunchTimeBoxingPowerHourThursdays = "Lunch-Time Boxing Power Hour Thursdays"
    case cardioBoxingThursdays5 = "Cardio Boxing Thursdays (5pm)"
    case cardioBoxingThursdays615 = "Cardio Boxing Thursdays (6:15pm)"
    case boxingSkillsThursdays = "Boxing Skills Thursdays (With Permission Only)"
    case morningBodyBlastFridays = "Morning Body Blast Fridays (With Permission Only)"
    case combatConditioningFridays = "Combat Conditioning Fridays"
    case teamPracticeFridays = "Team Practice Fridays (With Permission Only)"
    case cardioBoxingSaturdays9 = "Cardio Boxing Saturdays (9am)"
    case cardioBoxingSaturdays1030 = "Cardio Boxing Saturdays (10:30am)"
}

// UTILITIES
struct DateHandler {
    static let dateInputFormat = "MMM d, yyyy HH:mm"
    static let dateOutputFormat = "MMM d h:mm a"
    let formatter: DateFormatter
    
    init() {
        // default init assumes this is input for parsing the date format of a string
        formatter = DateFormatter(format: DateHandler.dateInputFormat)
    }
    
    init(format: String) {
        // alt init allows the user to specify the format, in case there are multiple output formats in the future
        formatter = DateFormatter(format: format)
    }
}

extension String {
    //This func returns a string with unnecessary date info stripped out
    func extractDate() -> String {
        let weekdays = Calendar.current.weekdaySymbols
        let additionalDescriptors = ["Today", "Tomorrow", "Next Week", "In 2 Weeks", "In 3 Weeks"]
        var mutableString = self
        
        for day in weekdays {
            if self.contains(day) {
                let range = mutableString.range(of: day + ", ")
                mutableString.removeSubrange(range!)
                for word in additionalDescriptors {
                    if mutableString.contains(word) {
                        let wordRange = mutableString.range(of: " " + word)
                        mutableString.removeSubrange(wordRange!)
                    }
                }
            }
        }
        return mutableString
    }
}

extension String {
    func toDate() -> Date? {
        DateHandler().formatter.date(from: self.extractDate())
    }
}

extension DateFormatter {
    convenience init(format: String) {
        self.init()
        self.dateFormat = format
    }
}

extension Date {
    func toString(format: String) -> String {
        DateHandler(format: format).formatter.string(from: self)
    }
}

// TEST

class WatchedClasses {
    var current: [MbaClass]?
    var past: [MbaClass]? {
        guard let currentClasses = self.current else {
            return nil
        }
        
        let now = Date()
        let past = currentClasses.filter() { $0.date < now }
        removeSelections(past)
        return past
    }
    
    var nowAvailable: [MbaClass]? {
        guard let currentClasses = self.current else {
            return nil
        }
        let availableClasses = currentClasses.filter() { $0.spotsAvailable != 0 }
        removeSelections(availableClasses)
        return availableClasses
    }
    
    init() {
//        self.current = DataStorage().retrieve() ?? []
        //handle past classes
    }
    
    func addNewSelections(_ selections: [MbaClass]) {
        if var currentSelections = self.current {
            currentSelections += selections
        } else {
            current = selections
        }
    }
    
    func removeSelections(_ selections: [MbaClass]) {
        if let currentSelections = self.current {
            var filtered = currentSelections
            for item in selections {
                if let index = filtered.firstIndex(of: item) {
                    filtered.remove(at: index)
                }
            }
            current = filtered
        }
    }
}



var class1 = MbaClass(name: "Team Practice Fridays (With Permission Only)", spotsAvailable: "0", date: "Friday, December 24, 2021")
var class2 = MbaClass(name: "Cardio Boxing Saturdays (9am)", spotsAvailable: "0", date: "Saturday, December 25, 2021")
var class3 = MbaClass(name: "Cardio Boxing Saturdays (10:30am)", spotsAvailable: "0", date: "Saturday, December 25, 2021")

var watchedClasses = WatchedClasses()
watchedClasses.current = [class1, class2, class3]

//class2.spotsAvailable = 1
//class3.date = "Saturday, December 18, 2021".extractDate().toDate() ?? Date()
//
//
//if let availableClasses = watchedClasses.nowAvailable {
//    for mbaclass in availableClasses {
//        print("Available: \(mbaclass.name)")
//    }
//}
//
//if let pastClasses = watchedClasses.past {
//    for mbaclass in pastClasses {
//        print("Past Class: \(mbaclass.name)")
//    }
//}

watchedClasses.removeSelections([class1])

if let currentClasses = watchedClasses.current {
    for session in currentClasses {
        print(session.name)
    }
}
