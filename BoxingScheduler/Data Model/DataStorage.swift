//
//  DataStorage.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/19/21.
//

import Foundation

struct DataStorage {
    func save(classList: [MbaClass]) throws {
        let fileManager = FileManager()
        let url = fileManager.getDocumentsDirectory().appendingPathComponent("classList.txt")
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: classList, requiringSecureCoding: false)
            try data.write(to: url)
        } catch {
            print("save failed")
        }
    }
    
    func retrieve() -> [MbaClass]? {
        let fileManager = FileManager()
        let url = fileManager.getDocumentsDirectory().appendingPathComponent("classList.txt")
        
        do {
            let data = try Data(contentsOf: url)
            if let decodedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [MbaClass] {
                return decodedData
            }
        } catch {
            return nil
        }
        return nil
    }
}
