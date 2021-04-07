//
//  ViewController.swift
//  OnboardingUsingColorAnimation
//
//  Created by Lucky on 07.04.2021.
//

import UIKit
import paper_onboarding

class ViewController: UIViewController {
    
    //MARK: - Properties
    let items = [OnboardingItemInfo(informationImage: UIImage(named: "airPods")!,
                                    title: "AirPods",
                                    description: "Powered by the Apple H1 headphone chip.  AirPods deliver a faster & more stable wireless connection to your devices up to 2x faster when switching between active devices & a 1.5x faster connection time for phone calls.",
                                    pageIcon: UIImage(named: "airPods")!,
                                    color: #colorLiteral(red: 1, green: 0.8254461391, blue: 0.9762687434, alpha: 1),
                                    titleColor: .black,
                                    descriptionColor: .gray,
                                    titleFont: UIFont(name: "AvenirNext-Bold", size: 26)!,
                                    descriptionFont: UIFont(name: "AvenirNext-Medium", size: 20)!),
                 OnboardingItemInfo(informationImage: UIImage(named: "tvBox")!,
                                                 title: "Cinematic in every sense.",
                                                 description: "Apple TV+ is a streaming service featuring Apple Originals award-winning series, compelling dramas, groundbreaking documentaries, kids’ entertainment, comedies, and more..",
                                                 pageIcon: UIImage(named: "tvBox")!,
                                                 color: #colorLiteral(red: 0.836862814, green: 1, blue: 0.9844924968, alpha: 1),
                                                 titleColor: .black,
                                                 descriptionColor: .gray,
                                                 titleFont: UIFont(name: "AvenirNext-Bold", size: 26)!,
                                                 descriptionFont: UIFont(name: "AvenirNext-Medium", size: 21)!),
                 OnboardingItemInfo(informationImage: UIImage(named: "appleCard")!,
                                                 title: "The simplicity of Apple. In a credit card.",
                                                 description: "With Apple Card, we completely reinvented the credit card. Advanced technologies like Face ID, Touch ID & Apple Pay give you a new level of privacy and security.",
                                                 pageIcon: UIImage(named: "appleCard")!,
                                                 color: .white,
                                                 titleColor: .black,
                                                 descriptionColor: .gray,
                                                 titleFont: UIFont(name: "AvenirNext-Bold", size: 26)!,
                                                 descriptionFont: UIFont(name: "AvenirNext-Medium", size: 21)!),
    ]

    //MARK: - @IBOutlets
    @IBOutlet weak var onboardingView: PaperOnboarding!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.dataSource = self
    }

    

}

//MARK: - Extensions
extension ViewController: PaperOnboardingDataSource {
    func onboardingItemsCount() -> Int {
        return items.count
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        items[index]
    }
    
    
}
