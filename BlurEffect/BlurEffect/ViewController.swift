//
//  ViewController.swift
//  BlurEffect
//
//  Created by Lucky on 17.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: -  Properties
    private let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "background"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.frame = view.bounds
        
        createBlur()
    }
    
    //MARK: - Helpers
    func createBlur() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectBlur = UIVisualEffectView(effect: blurEffect)
        visualEffectBlur.frame = view.bounds
        visualEffectBlur.alpha = 0
        view.addSubview(visualEffectBlur)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                visualEffectBlur.alpha = 1
            }
        }
    }
}
