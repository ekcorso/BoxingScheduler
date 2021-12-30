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
        var registerNotificationsButton = ColorChangingButton()
        view.addSubview(registerNotificationsButton)
        registerNotificationsButton.translatesAutoresizingMaskIntoConstraints = false
        registerNotificationsButton.setTitle("Enable notifications", for: .normal)
        registerNotificationsButton.titleLabel?.textColor = .white
        registerNotificationsButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        registerNotificationsButton.setBackgoundColor(.systemGreen, for: .normal)
        registerNotificationsButton.setBackgoundColor(.systemGreen.withAlphaComponent(0.3), for: .disabled)
        registerNotificationsButton.layer.cornerRadius = 8
        registerNotificationsButton.addTarget(self, action: #selector(registerLocal), for: .touchUpInside)
        return registerNotificationsButton
    }()
    
    lazy var scheduleNotificationsButton: ColorChangingButton = {
        var scheduleNotificationsButton = ColorChangingButton()
        view.addSubview(scheduleNotificationsButton)
        scheduleNotificationsButton.translatesAutoresizingMaskIntoConstraints = false
        scheduleNotificationsButton.setTitle("Schedule notifications", for: .normal)
        scheduleNotificationsButton.titleLabel?.textColor = .white
        scheduleNotificationsButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        scheduleNotificationsButton.setBackgoundColor(.systemGreen, for: .normal)
        scheduleNotificationsButton.setBackgoundColor(.systemGreen.withAlphaComponent(0.3), for: .disabled)
        scheduleNotificationsButton.layer.cornerRadius = 8
        scheduleNotificationsButton.addTarget(self, action: #selector(scheduleLocal), for: .touchUpInside)
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
        let center = UNUserNotificationCenter.current()
        
        // TODO: Remove sound?
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Permission granted")
                DispatchQueue.main.async {
                    self.registerNotificationsButton.isEnabled.toggle()
                }
            } else {
                print("Permission denied")
            }
        }
        
    }
    
    @objc func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Class Available"
        content.body = "Go to MBA website to sign up"
        
        // Setting the trigger to be non-repeating so that it only goes off when certain criteria is met
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
        print("Notification scheduled")
//        scheduleNotificationsButton.isEnabled = false
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
