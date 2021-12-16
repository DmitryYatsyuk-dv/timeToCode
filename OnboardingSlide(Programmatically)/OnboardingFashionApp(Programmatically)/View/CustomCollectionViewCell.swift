//
//  CustomCollectionViewCell.swift
//  OnboardingFashionApp(Programmatically)
//
//  Created by Lucky on 11.10.2021.
//

import UIKit

//protocol CustomCollectionViewCellDelegate: class {
//    func didTapSkipButton()
//}

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "cellID"
    
//    weak var delegate: CustomCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
                
        return label
    }()
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size: 25)
        button.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 26
        button.layer.borderWidth = 0.45
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        button.backgroundColor = #colorLiteral(red: 0.1035427517, green: 0.1035427517, blue: 0.1035427517, alpha: 1)
        button.alpha = 0.85
        
        return button
    }()
    
//    MARK: - Actions
    @objc func didTapSkipButton() {
        print("DEBUG: skip skip skip")
//        delegate?.didTapSkipButton()
    }
    
    //MARK: - Helpers
    
    func showSkipButton(isShow: Bool) {
        skipButton.isHidden = !isShow
    }
    
    func setupUI() {
        contentView.backgroundColor = .clear
        
        [titleLabel, descriptionLabel, skipButton].forEach({
            contentView.addSubview($0);
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        setConstraints()
    }
    
    func configureUI(with items: OnboardingModel) {
        titleLabel.text = items.title
        descriptionLabel.text = items.detail
    }
    
    func setConstraints() {
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 135),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21)
        ])
        
        // descriptionLabel
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100),

            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21)
        ])
        
//         skipButton
        NSLayoutConstraint.activate([
            skipButton.heightAnchor.constraint(equalToConstant: 48),
            skipButton.widthAnchor.constraint(equalToConstant: 250),
            skipButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            skipButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80)
        ])
    }
}
