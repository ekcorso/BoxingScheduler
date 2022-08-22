//
//  WatchedClasses.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/20/21.
//

import Foundation

class WatchedClasses {
    private var current: [MbaClass]? {
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
        
    init() {
        self.current = DataStorage().retrieve() ?? []
    }
    
    func getAllClasses() async -> [MbaClass] {
        let dateList = await Networking.fetchScheduleData()
        var classList = [MbaClass]()
        for date in dateList {
            for mbaClass in date.classes {
                classList.append(mbaClass)
            }
        }
        
        return classList
    }
    
    func getNowAvailableClasses(from allClasses: [MbaClass]) -> [MbaClass] {
        guard let watched = self.current else {
            return [MbaClass]()
        }
        
        let availableClasses = allClasses.filter() {
            watched.contains($0) && $0.spotsAvailable > 0
        }
        
        // Update any classes that now have open spots as of this check
        for mbaClass in availableClasses {
            if let watchedClass = watched.first(where: {$0 == mbaClass }) {
                watchedClass.spotsAvailable = mbaClass.spotsAvailable
            }
        }
        
        self.current = watched
        
        let orderedArray = Array(Set(availableClasses))
        
        return orderedArray
    }
    
    func getCurrentWatched() async -> [MbaClass] {
        removePastClassesfromCurrent()
        guard let watched = self.current else {
            return []
        }
        
        let classes = await getAllClasses()
        let updatedClasses = classes.filter() { watched.contains($0) } // This updates the spotsAvailable with the most recent data
        return updatedClasses
    }
    
    func setCurrentWatched(_ newCurrent: [MbaClass]) {
        self.current = newCurrent
    }
    
    private func removePastClassesfromCurrent() {
        guard let watched = self.current else {
            return
        }
        
        let now = Date()
        
        let upcomingClasses = watched.filter() { $0.date >= now }
        self.current = upcomingClasses
    }
}

