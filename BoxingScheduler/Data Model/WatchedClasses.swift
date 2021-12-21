//
//  WatchedClasses.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/20/21.
//

import Foundation

class WatchedClasses {
    var current: [MbaClass]?
    var past: [MbaClass]? = [MbaClass]()
    
    init() {
        self.current = DataStorage().retrieve() ?? []
    
    }
    
    func addNewSelections(_ selections: [MbaClass]) {
        if var currentSelections = self.current {
            currentSelections += selections
            // Save to DataStorage
        } else {
            current = selections
            // Save to DataStorage
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
            // Save to DataStorage
        }
    }
    
    private func moveToPast() {
        guard let currentClasses = self.current else {
            return
        }
        
        let now = Date()
        past = currentClasses.filter() { $0.date < now }
        // Save to DataStorage
    }
}
