//
//  ViewController.swift
//  BiometricAuth
//
//  Created by Lucky on 15.03.2021.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = GradientButton(colors: [UIColor.systemGray.cgColor,
                                             UIColor.darkGray.cgColor])
        button.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        
        view.addSubview(button)
        button.center = view.center
        button.alpha = 0.78
        button.setTitle("TouchID&FaceID", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    //MARK: - Helpers
    @objc
    func didTapButton() {
        print("DEBUG: bla-bla-bla")
        
        let contex = LAContext()
        var error: NSError? = nil
        if contex.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                    error: &error) {
            let reason = "Please authorize with Touch ID"
            contex.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                  localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success,
                          error == nil else {
                        let alert = UIAlertController(title: "Failed to authenticate!",
                                                      message: "Please try again.",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style: .cancel,
                                                      handler: nil))
                            self?.present(alert, animated: true)
                        return
                    }
                let vc = UIViewController()
                    vc.title = "Access granted"
                    vc.view.backgroundColor = .darkGray
                    self?.present(UINavigationController(rootViewController: vc),
                                  animated: true,
                                  completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Access Denied!",
                                          message: "You can't use this feauture & don't have permission to access.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel,
                                          handler: nil))
            present(alert, animated: true)
        }
    }
}
