//
//  CustomView.swift
//  OnboardingVideoPart(Programmatically)
//
//  Created by Lucky on 16.11.2021.
//

import UIKit

protocol CustomViewDelegate: class {
    func testDelegate()
}

class CustomView: UIView {
    
    public var handlerStartButton: (() -> Void)?
    weak var delegate: CustomViewDelegate?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    private let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.4)
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "To Improve Your Team,\nFirst Work on Yourself"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 27
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.01071632209, green: 0.7149621212, blue: 0.01279208168, alpha: 0.8846629566)

        return button
    }()
    
    //MARK: - Actions
    @objc
    func didTapStartButton() {
        print("DEBUG: Signal from CustomView")
         
        #warning("callback")
        handlerStartButton?()
        #warning("delegate")
        delegate?.testDelegate()
        
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, startButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        
        
        [firstView, stackView].forEach {
            self.addSubview($0);
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
    
    func setupConstraints() {
        // view
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: self.topAnchor),
            firstView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            firstView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        // startButton
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 55),
            startButton.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
}
