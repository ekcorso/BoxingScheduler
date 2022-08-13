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
        removePastClassesfromCurrent()
    }
    
    func addNewSelections(_ selections: [MbaClass]) {
        if var currentSelections = self.current {
            let allSelections: [MbaClass] = currentSelections + selections
            currentSelections = Array(Set(allSelections))
            
            do {
                try DataStorage().save(currentSelections)
            } catch {
                print("Save failed")
            }
        } else {
            current = selections
        }
    }
    
    //This func updates the class's allClassesFromAPI property when it is called in the initializer
    func getAllClasses(completion: @escaping ([MbaClass]) -> ()) {
        var dateList = [ClassDate]()
        var classList = [MbaClass]()
        Networking.fetchScheduleData() { dates in
            dateList += dates.filter() { !dateList.contains($0) }
            
            for date in dateList {
                for mbaClass in date.classes {
                    classList.append(mbaClass)
                }
            }
            completion(classList)
        }
    }
    
    // This func sorts updates the currently watched classes' spotsAvailable property when spots open up then adds that class to the nowAvailable list and returns that list. Call this inside the completion handler for getAllClasses.
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
    
    func getCurrentWatched(completion: @escaping ([MbaClass]) -> ()) {
        removePastClassesfromCurrent()
        guard let watched = self.current else {
            return
        }
                
        getAllClasses() { allClasses in // allClasses supposedly has a count of about 15, but that's probably not all of the classes. How do I get the other pages?
            
            let updatedList = allClasses.filter() { watched.contains($0) }
            
            let currentWatched = Array(Set(updatedList)) // Why is there duplication without this?
            completion(currentWatched)
        }
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

