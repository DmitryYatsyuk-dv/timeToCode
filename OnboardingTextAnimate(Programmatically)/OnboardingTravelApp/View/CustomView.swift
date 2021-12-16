//
//  CustomView.swift
//  OnboardingTravelApp
//
//  Created by Lucky on 10.10.2021.
//

import UIKit

class CustomView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: - Properties
  
    //MARK: - Actions
        
    //MARK: - Helpers
    func setupUI() {}
    func setupConstraints() {}
}
