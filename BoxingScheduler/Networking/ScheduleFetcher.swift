//
//  ScheduleFetcher.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/14/21.
//

import Foundation
import SwiftSoup
import Combine

class ScheduleFetcher {
    var dateList: [ClassDate]? {
        didSet {
            if let dateList = dateList {
                print("DateList updated")
            }
        }
    }
    
    func getUrlContent(completion: @escaping ([ClassDate]) -> Void) {
        guard let url = URL(string: "https://app.squarespacescheduling.com/schedule.php?action=showCalendar&fulldate=1&owner=19967298&template=class"), let payloadPage1 = "type=&calendar=&skip=true&options%5Boffset%5D=0&options%5BnumDays%5D=5&ignoreAppointment=&appointmentType=&calendarID=".data(using: .utf8), let payloadPage2 = "type=&calendar=&skip=true&options%5Boffset%5D=15&options%5BnumDays%5D=5&ignoreAppointment=&appointmentType=&calendarID=".data(using: .utf8), let payloadPage3 = "type=&calendar=&skip=true&options%5Boffset%5D=30&options%5BnumDays%5D=5&ignoreAppointment=&appointmentType=&calendarID=".data(using: .utf8), let payloadPage4 = "type=&calendar=&skip=true&options%5Boffset%5D=45&options%5BnumDays%5D=5&ignoreAppointment=&appointmentType=&calendarID=".data(using: .utf8) else {
            print("One of the urls is incorrect")
            return
        }
        
        var payloadArray = [payloadPage1, payloadPage2, payloadPage3, payloadPage4]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "content-type")
        for payload in payloadArray {
            request.httpBody = payload
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let data = data else {
                    print("Empty data")
                    return
                }
                if let str = String(data: data, encoding: .utf8) {
                    let stringData = self.parseHtml(fromString: str)
                    completion(self.createDateList(from: stringData!))
                }
            }
            
            dataTask.resume()
        }
    }

    private func parseHtml(fromString: String) -> Document? {
        do {
            let html: String = fromString
            let doc: Document = try SwiftSoup.parse(html)
            return doc
        } catch Exception.Error(_, let message) {
            print(message)
            return nil
        } catch {
            print("error")
            return nil
        }
    }

    private func createDateList(from doc: Document) -> [ClassDate] {
        var dateArray = [ClassDate]()
        guard let elements = try? doc.select("tr") else {
            print("select for tr failed")
            return dateArray
        }

        for (index, item) in elements.enumerated() {
            let date = ClassDate()
            do {
                if item.hasClass("class-date-row") {
                    let exactDate = try item.select(".class-date-row").text()
                    date.exactDate = exactDate
                    dateArray.append(date)
                } else if try! item.className().contains("class-row-xs") {
                    let name = try item.select(".class-name").text()
                    let spotsAvailable = try elements[index + 1].select(".class-spots").text()
                    let date = dateArray.last?.exactDate ?? Date().toString(format: DateHandler.dateOutputFormat)
                    let boxingClass = MbaClass(name: name, spotsAvailable: spotsAvailable, date: date)
                    if let previousDate = dateArray.last {
                        previousDate.classes.append(boxingClass)
                    }
                }
            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("other exception")
            }
        }
        
//        for date in dateArray {
//            print("Classes on date \(date.exactDate!): \(date.classes.count)")
//        }
        return dateArray
    }
}
