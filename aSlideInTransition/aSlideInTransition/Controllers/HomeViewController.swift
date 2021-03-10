//
//  ViewController.swift
//  aSlideInTransition
//
//  Created by Lucky on 23.02.2021.
//

import UIKit

class HomeViewController: UIViewController {
    let transition = SlideInTransition()
    var topView: UIView?
    var menuVC = MenuViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            print("DEBUG: \(menuType)")
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true, completion: nil)
    }
    
    func transitionToNew(_ menuType: MenuType) {
        let title = String(describing: menuType).capitalized
        self.title = title
        
        topView?.removeFromSuperview()
        
        switch menuType {
        case .profile:
            let view = UIView()
            view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9175334892, green: 0.7601545785, blue: 0.5913481973, alpha: 1))
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        case .camera:
            let view = UIView()
            view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.6605301663, green: 0.5445308403, blue: 0.9805159135, alpha: 0.5838291598))
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        case .todo:
            let view = UIView()
            view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9372549057, green: 0.486034334, blue: 0.1881728648, alpha: 0.5088868804))
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        case .settings:
            let view = UIView()
            view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 1, green: 0.08795686908, blue: 0.05530254156, alpha: 0.5101480042))
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
//        case .house:
//            let view = UIView()
//            view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 0.5206662614))
//            view.frame = self.view.bounds
//            self.view.addSubview(view)
//            self.topView = view
        case .info:
            let view = UIView()
            view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0.5063371469))
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        case .house:
            print("DEBUG: This is a houseVC ")
        }
    }
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
