//
//  SettingsViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/30/21.
//

import Foundation
import UIKit
import UserNotifications

class SettingsViewController: UIViewController {
    
    lazy var registerNotificationsButton: ColorChangingButton = {
        var registerNotificationsButton = ColorChangingButton(title: "Enable notifications", backgroundColor: .systemGreen)
        
        registerNotificationsButton.addTarget(self, action: #selector(registerLocal), for: .touchUpInside)
        registerNotificationsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerNotificationsButton)
        
        return registerNotificationsButton
    }()
    
    lazy var scheduleNotificationsButton: ColorChangingButton = {
        var scheduleNotificationsButton = ColorChangingButton(title: "Schedule notifications", backgroundColor: .systemBlue)
        
        scheduleNotificationsButton.addTarget(self, action: #selector(scheduleLocal), for: .touchUpInside)
        scheduleNotificationsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scheduleNotificationsButton)
        
        return scheduleNotificationsButton
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.addArrangedSubview(registerNotificationsButton)
        stackView.addArrangedSubview(scheduleNotificationsButton)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        
        setConstraints()
    }
    
    @objc func registerLocal() {
        NotificationHandler().registerNotifications()
    }
    
    @objc func scheduleLocal() {
        NotificationHandler().scheduleAvailableClassNotification()
    }
}

extension SettingsViewController {
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -40),
        ])
        
    }
}
