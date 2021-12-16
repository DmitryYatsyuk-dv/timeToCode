//
//  OnboardingModel.swift
//  OnboardingFashionApp(Programmatically)
//
//  Created by Lucky on 19.10.2021.
//

import UIKit


struct OnboardingModel {
    let title: String
    let detail: String
    let image: UIImage?
    
    static let placeholderItems: [OnboardingModel] = [
        .init(title: "The New York Times",
              detail: "We believe that great journalism has the power to make each reader’s life richer and all of society stronger and more just.",
              image: UIImage(named: "nyImage")),
        .init(title: "models &..",
              detail: "Models magazine is the leading interactive fashion database connecting the world to models, creative talent, magazines, and luxury and commercial brands.",
              image: UIImage(named: "modelImage")),
        .init(title: "GQ",
              detail: "GQ-(formerly Gentlemen's Quarterly) is an American international monthly men's magazine based in New York City and founded in 1931.",
              image: UIImage(named: "gqImage1")),
        .init(title: "BBC Science Focus",
              detail: "BBC SFM is the UK's leading science and technology monthly. From space travel to brain science and the big breakthroughs affecting our future..",
              image: UIImage(named: "tecImage"))
    ]
}
