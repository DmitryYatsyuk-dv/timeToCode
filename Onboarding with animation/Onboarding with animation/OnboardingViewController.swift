//
//  ViewController.swift
//  Onboarding with animation
//
//  Created by Lucky on 05.04.2021.
//

import UIKit
import Lottie

struct Slide {
    let title: String
    let animationName: String
    let buttonColor: UIColor
    let buttonTitle: String
    
    static let collection: [Slide] = [
        
        .init(title: "Your personal information must be kept confidential",
              animationName: "dataSecurity",
              buttonColor: #colorLiteral(red: 0.4093281106, green: 0.6083296744, blue: 0.8287908381, alpha: 1),
              buttonTitle: "Continue"),
        .init(title: "Block malware and phishing",
              animationName: "umbrella",
              buttonColor: #colorLiteral(red: 0.508839395, green: 0.7570813112, blue: 0.4634519199, alpha: 1),
              buttonTitle: "Continue"),
        .init(title: "Surf the web securely",
              animationName: "Private",
              buttonColor: #colorLiteral(red: 0.7790231416, green: 0.4718102431, blue: 0.7540604124, alpha: 1),
              buttonTitle: "Continue"),
        .init(title: "You and your loved ones are protected - privacy you can trust",
              animationName: "Together",
              buttonColor: #colorLiteral(red: 0.5709140834, green: 0.6151734082, blue: 1, alpha: 1),
              buttonTitle: "Continue"),
            .init(title: "We are more than your friends, we are your shadow!",
                  animationName: "finger",
                  buttonColor: #colorLiteral(red: 0.7953972094, green: 0.6277865411, blue: 0.3128105528, alpha: 1),
                  buttonTitle: "Excellent")
        
//        .init(title: "Job Hunt",
//              animationName: "jobHunt",
//              buttonColor: #colorLiteral(red: 0.4093281106, green: 0.6083296744, blue: 0.8287908381, alpha: 1),
//              buttonTitle: "Strap in"),
//        .init(title: "Interviewing for a job",
//              animationName: "interviewing",
//              buttonColor: #colorLiteral(red: 0.508839395, green: 0.7570813112, blue: 0.4634519199, alpha: 1),
//              buttonTitle: "Next"),
//        .init(title: "Writing a cover letter & resumes",
//              animationName: "resumes",
//              buttonColor: #colorLiteral(red: 0.7790231416, green: 0.4718102431, blue: 0.7540604124, alpha: 1),
//              buttonTitle: "Next"),
//        .init(title: "Selection of job offers",
//              animationName: "selectionOffers",
//              buttonColor: #colorLiteral(red: 0.5709140834, green: 0.6151734082, blue: 1, alpha: 1),
//              buttonTitle: "Next"),
//            .init(title: "Signing a job offer",
//                  animationName: "signingOffer",
//                  buttonColor: #colorLiteral(red: 0.7953972094, green: 0.6277865411, blue: 0.3128105528, alpha: 1),
//                  buttonTitle: "Excellent")
    ]
}


class OnboardingViewController: UIViewController {
    
    private let slides: [Slide] = Slide.collection
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var  pageControl: UIPageControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupPageControl()
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = slides.count
        let angle = CGFloat.pi/2
        pageControl.transform = CGAffineTransform(rotationAngle: angle)
        
    }
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        
        collectionView.isPagingEnabled = true
        // Hide status bar
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    private func handleActionButtonTap(at indexPath: IndexPath) {
        if indexPath.item == slides.count - 1 {
            showMainApp()
        } else {
            let nextItem = indexPath.item + 1
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.scrollToItem(at: nextIndexPath ,
                                        at: .top,
                                        animated: true)
            pageControl.currentPage = nextItem
            
        }
    }
    
    private func showMainApp() {
        
        let mainAppViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainAppViewController")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate =  windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = mainAppViewController
            UIView.transition(with: window,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: nil, completion: nil)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.y / scrollView.frame.size.height)
        print("DEBUG: index->\(index)")
        pageControl.currentPage = index
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
}


extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardingCollectionViewCell
        
        let slide = slides[indexPath.item]
        cell.configure(with: slide)
        cell.actionButtonDidTap = { [weak self] in
            self?.handleActionButtonTap(at: indexPath)
        }
        return cell
        
        //        var color = UIColor.clear
        //        if indexPath.item % 2 == 0 {
        //            color = .cyan
        //        } else {
        //            color = .systemIndigo
        //        }
        //        cell.backgroundColor = color
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    
    var actionButtonDidTap: (() -> Void)?
    
    
    @IBAction func actionButtonTapped() {
        actionButtonDidTap?()
    }
    
    
    func configure(with slide: Slide) {
        titleLabel.text = slide.title
        actionButton.backgroundColor = slide.buttonColor
        actionButton.setTitle(slide.buttonTitle, for: .normal)
        
        let animation = Animation.named(slide.animationName)
        animationView.animation = animation
        animationView.loopMode = .loop
        
        if !animationView.isAnimationPlaying {
            animationView.play()
        }
    }
}
