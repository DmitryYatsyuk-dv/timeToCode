//
//  SlideInTransition.swift
//  aSlideInTransition
//
//  Created by Lucky on 23.02.2021.
//

import UIKit

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    let dimmingView = UIView()
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from)
        else { return }
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.65
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting {
            
            // Add dimming view
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            
            // Add menu viewController to container
            containerView.addSubview(toViewController.view)
            containerView.alpha = 1
            
            // Initial frame for the menu viewController - off the screen
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0,
                                                 width: finalWidth,
                                                 height: finalHeight)
        }
        // Animate on to screen
        let transform = {
             self.dimmingView.alpha = 0.45
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        // Animate back off screen
        let identity = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        
        // Animation of the transition
        UIView.animate(withDuration: duration) {
            self.isPresenting ? transform() : identity()
        } completion: { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
    }
}
