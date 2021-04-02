//
//  ViewController.swift
//  ExamplePop-up
//
//  Created by Lucky on 01.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var centerPopupConstraints: NSLayoutConstraint!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    }
    
    //MARK: - @IBActions
    @IBAction func showPopup(_ sender: Any) {
        centerPopupConstraints.constant = 0
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.2) {
            self.backgroundButton.alpha = 0.5

        }
    }
    @IBAction func closePopup(_ sender: Any) {
        centerPopupConstraints.constant = -400
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        }
    }
}
