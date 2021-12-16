//
//  MbaClassTableViewCell.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/14/21.
//

import UIKit

class MbaClassTableViewCell: UITableViewCell {
    static let identifier = "CustomClassCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCellText(mbaClass: MbaClass) {
        textLabel?.text = "\(mbaClass.name)"
        detailTextLabel?.text = "Spots available: \(mbaClass.spotsAvailable)"
    }
}
