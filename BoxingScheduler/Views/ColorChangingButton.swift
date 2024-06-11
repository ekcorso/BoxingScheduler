//
//  ColorChangingButton.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/30/21.
//

import Foundation
import UIKit

class ColorChangingButton: UIButton {
    var config = UIButton.Configuration.filled()
    
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        config.title = title
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.baseForegroundColor = .white
        config.baseBackgroundColor = backgroundColor
        config.cornerStyle = .capsule
        
        self.configuration = config
        
        self.setDisabledStateColor(for: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setDisabledStateColor(for color: UIColor) {
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            if button.isEnabled {
                self.config.baseBackgroundColor = color
            } else {
                self.config.baseBackgroundColor = color.withAlphaComponent(0.3)
            }
        }
        
        self.configurationUpdateHandler = handler
    }
}
