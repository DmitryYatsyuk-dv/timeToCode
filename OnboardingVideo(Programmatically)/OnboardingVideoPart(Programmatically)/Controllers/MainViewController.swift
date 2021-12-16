//
//  MainViewController.swift
//  OnboardingVideoPart(Programmatically)
//
//  Created by Lucky on 17.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Have a nice day!"
        label.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
        
        setupUI()
    }
    
    //MARK: - Actions
    //MARK: - Helpers
    private func setupUI() {
        [titleLabel].forEach {
            view.addSubview($0);
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
