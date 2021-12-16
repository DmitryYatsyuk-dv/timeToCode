//
//  OnboardModel.swift
//  OnboardingTravelApp
//
//  Created by Lucky on 10.10.2021.
//

import UIKit

struct OnboardModel {
    let title: String
    let detail: String
    let bgImage: UIImage?
    
    static let placeholderItems: [OnboardModel] = [
        .init(title: "A healthy trip to mountain heights",
              detail: "The effect of altitude. Altitude starts having an effect on the body at about 1500-2000m above sea level.\nThe body will change and behave differently as it tries to adapt to the altered oxygen level..",
              bgImage: UIImage(named: "image0")),
        .init(title: "Why WaterFalls Are Important ?",
              detail: "Waterfalls also help in reducing stress and depression.\nThe negative ions released causes calmness and this somehow alleviates the stress and depression.",
              bgImage: UIImage(named: "image1")),
        .init(title: "Oh.. The best place for",
              detail: "Yoga, meditation, relax..",
              bgImage: UIImage(named: "image2")),
        .init(title: "Lakes & mineral springs",
              detail: " Soaking up the sun while inhaling the scent of salt water is one of life's pleasures. ",
              bgImage: UIImage(named: "image3"))
    ]
}
