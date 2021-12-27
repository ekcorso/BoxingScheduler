//
//  WatchedClasses.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/20/21.
//

import Foundation

class WatchedClasses {
    var current: [MbaClass]? {
        didSet {
            // Re-save the current list anytime it is updated (for instance by the methods that remove past/ available classes as those arrays are computed
            if let current = current {
                do {
                    try DataStorage().save(current)
                } catch {
                    print("saving current classes failed")
                }
            }
        }
    }
    
    var past: [MbaClass]? {
        guard let currentClasses = self.current else {
            return nil
        }
        
        let now = Date()
        
        // Initialize past selections array by filtering the current watched classes for dates that have past
        let past = currentClasses.filter() { $0.date < now }
        // removeSelections is commented out to keep from removing past classes so they can be potentially be used for testing
        //        removeSelections(past)
        return past
        
    }
    
    var nowAvailable: [MbaClass]?
    
    init() {
        self.current = DataStorage().retrieve() ?? []
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
