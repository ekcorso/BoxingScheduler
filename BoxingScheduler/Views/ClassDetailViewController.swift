//
//  ClassDetailViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/14/21.
//

import UIKit

class ClassDetailViewController: UIViewController {
    var mbaClass: MbaClass?
    
    lazy var spacerView1: UIView = {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spacer)
        return spacer
    }()
    
    lazy var spacerView2: UIView = {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spacer)
        return spacer
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name: \(mbaClass!.name)"
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 0
        
        view.addSubview(nameLabel)
        return nameLabel
    }()
    
    lazy var spotsAvailableLabel: UILabel = {
        let spotsAvailableLabel = UILabel()
        
        spotsAvailableLabel.translatesAutoresizingMaskIntoConstraints = false
        spotsAvailableLabel.text = "Spots: \(mbaClass!.spotsAvailable)"
        spotsAvailableLabel.textColor = .label
        spotsAvailableLabel.numberOfLines = 0
        
        view.addSubview(spotsAvailableLabel)
        return spotsAvailableLabel
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        
        stackView.addArrangedSubview(spacerView1)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(spotsAvailableLabel)
        stackView.addArrangedSubview(spacerView2)
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Class Details"
        
        setConstraints()
    }
}

extension ClassDetailViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            spacerView1.heightAnchor.constraint(equalToConstant: 100),
            spacerView2.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
}
