//
//  Networking.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/14/21.
//

import Foundation
import SwiftSoup
import Combine

class Networking {
    static let urlSession = URLSession(configuration: .default)
    var dateList: [ClassDate]? {
        didSet {
            if dateList != nil {
                print("DateList updated")
            }
        }
    }
    
    static func fetchScheduleData() async -> [ClassDate] {
        guard let url = URL(string: "https://app.squarespacescheduling.com/schedule.php?action=showCalendar&fulldate=1&owner=19967298&template=class"), let payloadPage1 = "type=&calendar=&skip=true&options%5Boffset%5D=0&options%5BnumDays%5D=5&ignoreAppointment=&appointmentType=&calendarID=".data(using: .utf8), let payloadPage2 = "type=&calendar=&skip=true&options%5Boffset%5D=15&options%5BnumDays%5D=5&ignoreAppointment=&appointmentType=&calendarID=".data(using: .utf8), let payloadPage3 = "type=&calendar=&skip=true&options%5Boffset%5D=30&options%5BnumDays%5D=5&ignoreAppointment=&appointmentType=&calendarID=".data(using: .utf8), let payloadPage4 = "type=&calendar=&skip=true&options%5Boffset%5D=45&options%5BnumDays%5D=5&ignoreAppointment=&appointmentType=&calendarID=".data(using: .utf8) else {
            print("One of the urls is incorrect")
            // TODO: Throw error here instead
            return []
        }
        
        let payloadArray = [payloadPage1, payloadPage2, payloadPage3, payloadPage4]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "content-type")
        var fullDateList = [ClassDate]()
        
        
        for payload in payloadArray {
            request.httpBody = payload
            
            do {
                let (data, _) = try await Networking.urlSession.data(for: request)
                
                if let str = String(data: data, encoding: .utf8) {
                    let htmlDoc = self.parseHtmlDoc(fromString: str)
                    let dateList = self.buildDateList(from: htmlDoc!)
                    fullDateList += dateList
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return fullDateList
    }

    private static func parseHtmlDoc(fromString: String) -> Document? {
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

    private static func buildDateList(from doc: Document) -> [ClassDate] {
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
        return dateArray
    }
}
