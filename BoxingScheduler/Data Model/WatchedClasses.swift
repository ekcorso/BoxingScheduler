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