//
//  WatchedClasses2.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/25/21.
//

import Foundation

class WatchedClasses2 {
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
        // removeSelections is commented out to keep from removing past classes so they can be potentially be used for testing
//        removeSelections(past)
        return past
    }
    
    
    var allClassesFromAPI: [MbaClass]?
//    {
//        guard let currentWatchedClasses = self.current else {
//            print("No current at this point")
//            return [MbaClass]()
//
//        }
//        let allClasses = getallCurrentClasses()
//        if let index = allClasses.firstIndex(of: (currentWatchedClasses[3])) {
//            let relevantClass = allClasses[index]
//            relevantClass.spotsAvailable = 2
//            print("\(relevantClass.name) has \(relevantClass.spotsAvailable)")
//            print("Footwork spots updated")
//        }
//        return allClasses
//    }
    
    var nowAvailable: [MbaClass]? {
        guard let currentWatchedClasses = self.current else {
            return nil
        }
//        let availableClasses = currentClasses.filter() { $0.spotsAvailable != 0 }
//        removeSelections(availableClasses)
//        return availableClasses
        
        print("\(currentWatchedClasses[3].name) -- \(currentWatchedClasses[3].spotsAvailable)")
        
        var availableClasses = [MbaClass]()
        for watchedClass in currentWatchedClasses {
            for mbaClass in allClassesFromAPI! {
                if watchedClass.name == mbaClass.name && watchedClass.date == mbaClass.date && mbaClass.spotsAvailable != 0 {
                    watchedClass.spotsAvailable = mbaClass.spotsAvailable
                    availableClasses.append(watchedClass)
                }
            }
        }
        
        // removeSelections is commented out to keep from removing past classes so they can be potentially be used for testing
//        removeSelections(availableClasses)
        return availableClasses
    }
    
    init() {
        self.current = DataStorage().retrieve() ?? []
        getallCurrentClasses()
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
    
    //
    private func getallCurrentClasses() {
        let fetcher = ScheduleFetcher()
        var dateList = [ClassDate]()
        var classList = [MbaClass]()
        fetcher.getUrlContent() { dates in
            dateList = dates
            
            for date in dateList {
                for mbaClass in date.classes {
                    classList.append(mbaClass)
                    print("appending to classList")
                }
            }
            self.allClassesFromAPI = classList
        }
        
    }
    
    //
    private func updateSpotsAvailable() {
        guard let currentClasses = self.current else {
            return
        }

        var availableClasses = [MbaClass]()
        for watchedClass in currentClasses {
            for mbaClass in allClassesFromAPI! {
                if watchedClass.name == mbaClass.name && watchedClass.date == mbaClass.date && mbaClass.spotsAvailable != 0 {
                    watchedClass.spotsAvailable = mbaClass.spotsAvailable
                    availableClasses.append(watchedClass)
                    print("\(mbaClass.name) now has \(mbaClass.spotsAvailable) spots available")
                }
            }
        }
    }
}
