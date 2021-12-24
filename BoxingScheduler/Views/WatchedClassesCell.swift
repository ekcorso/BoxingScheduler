//
//  WatchedClassesCell.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/23/21.
//

import Foundation
import UIKit

class WatchedClassesCell: UITableViewCell {
    static let identifier = "WatchedClassesCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCellText(mbaClass: MbaClass) {
        textLabel?.text = "\(mbaClass.name)"
        detailTextLabel?.text = "\(mbaClass.date.toString(format: DateHandler.dateOutputFormat))"
    }
}
