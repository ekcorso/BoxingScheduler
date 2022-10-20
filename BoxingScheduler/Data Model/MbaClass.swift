//
//  MbaClass.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/1/21.
//

import Foundation

class MbaClass: NSObject, NSCoding {
    // name could have an enum
    var name: String = ""
    var spotsAvailable: Int = 0
    var date: Date = Date()
    var time: String = ""
    
    init(name: String, spotsAvailable: String, date: Date) {
        super.init()
        self.name = name
        self.spotsAvailable = getSpotsAsInt(from: spotsAvailable)
        self.date = date
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
    
}

extension MbaClass {
    override func isEqual(_ object: Any?) -> Bool {
        if name == (object as? MbaClass)?.name && date == (object as? MbaClass)?.date {
            return true
        } else {
            return false
        }
    }
}

extension MbaClass: Comparable {
    static func < (lhs: MbaClass, rhs: MbaClass) -> Bool {
        return lhs.date < rhs.date
    }
}
