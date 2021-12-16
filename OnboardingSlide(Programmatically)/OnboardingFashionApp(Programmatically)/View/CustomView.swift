//
//  CustomView.swift
//  OnboardingFashionApp(Programmatically)
//
//  Created by Lucky on 11.10.2021.
//

import UIKit

class CustomView: UIView {
    
    public var handlerNextButton: (() -> Void)?
    
    override init(frame: CGRect ) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    //MARK: - Properties
        
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 24)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)

        return button
    }()

    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.isUserInteractionEnabled = false
        
        return pageControl
    }()
    

    //MARK: - Actions
    @objc
    func didTapNextButton(_ sender: UIButton) {
        handlerNextButton?()
    }
    
    //MARK: - Helpers
    func setupUI() {
         [pageControl, nextButton].forEach {
            self.addSubview($0);
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setConstraints() {
        
        // nextButton
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])

        // pageControl
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: self.nextButton.bottomAnchor)
        ])
    }
}
