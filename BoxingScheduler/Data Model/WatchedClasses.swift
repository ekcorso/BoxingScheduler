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
        
    init() {
        self.current = DataStorage().retrieve() ?? []
        removePastClassesFromCurrent()
    }
    
    func addNewSelections(_ selections: [MbaClass]) {
        if var currentSelections = self.current {
            currentSelections += selections
        } else {
            current = selections
        }
    }
    
    //Removes classes whose dates have passed from the current array
    func removeSelections(_ selections: [MbaClass]) {
        if let currentSelections = self.current {
            var filtered = currentSelections
            for item in selections {
                if let index = filtered.firstIndex(of: item) {
                    filtered.remove(at: index)
                }
            }
            current = filtered
            
            do {
                try DataStorage().save(filtered)
            } catch {
                print("Saving failed")
            }
        }
    }
    
    //This func updates the class's allClassesFromAPI property when it is called in the initializer
    func getAllClasses(completion: @escaping ([MbaClass]) -> ()) {
        let fetcher = ScheduleFetcher()
        var dateList = [ClassDate]()
        var classList = [MbaClass]()
        fetcher.getUrlContent() { dates in
            dateList = dates
            
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
        guard let currentClasses = self.current else {
            return [MbaClass]()
        }
        
        var availableClasses = [MbaClass]()
        
        for watchedClass in currentClasses {
            for fetchedClass in allClasses{
                // The following line is ONLY for testing: it creates at least one class that has spotsAvailable
                fetchedClass.spotsAvailable = 2
                //Check for a fetchedClass that matches a watchedClass AND has at least one spot available
                if watchedClass.name == fetchedClass.name && watchedClass.date == fetchedClass.date && fetchedClass.spotsAvailable != 0 {
                    watchedClass.spotsAvailable = fetchedClass.spotsAvailable
                    availableClasses.append(watchedClass)
                    
                    do {
                        try DataStorage().save(currentClasses)
                    } catch {
                        print("Saving failed")
                    }
                }
            }
        }
        
        return availableClasses
    }
    
    private func removePastClassesFromCurrent() {
            guard let currentClasses = self.current else {
                return
            }
            
            let now = Date()
            
            // Initialize past selections array by filtering the current watched classes for dates that have passed
            let past = currentClasses.filter() { $0.date < now }
            // removeSelections is commented out to keep from removing past classes so they can be potentially be used for testing
            removeSelections(past)
    }
}

