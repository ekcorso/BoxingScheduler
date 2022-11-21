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
            // Re-save the current list anytime it is updated (for instance by the methods that remove past/ available classes as those arrays are computed)
            if let current = current {
                do {
                    try DataStorage().saveWatched(current)
                } catch {
                    print("saving current classes failed")
                }
            }
        }
    }
        
    init() {
        self.current = DataStorage().retrieveWatched() ?? []
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
    
    func filterForNowAvailableClasses(from allClasses: [MbaClass]) -> [MbaClass] {
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
        
        // Note that updating the saved current property is a side-effect of calling this method
        self.current = watched
        
        let orderedArray = Array(Set(availableClasses))
        
        return orderedArray
    }
    
    // TODO: Would be nice to refactor this as a direct fetch so that availableClasses doesn't need to be passed into it
    func createClassDatesFromClasses(_ availableClasses: [MbaClass]?) -> [ClassDate] {
        guard let availableClasses = availableClasses else {
            return []
        }
        var classDateArray = [ClassDate]()
        
        let classesByDate = Dictionary(grouping: availableClasses, by: { $0.date })
        
        for (key, value) in classesByDate {
            classDateArray.append(ClassDate(date: key, classes: value))
        }
        
        return classDateArray.sorted()
    }
    
    func getCurrentWatched() async -> [MbaClass] {
        removePastClassesfromCurrent()
        guard let watched = self.current else {
            return []
        }
        
        let classes = await getAllClasses()
        let updatedClasses = classes.filter() { watched.contains($0) } // This updates the spotsAvailable with the most recent data
        return updatedClasses.sorted()
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

