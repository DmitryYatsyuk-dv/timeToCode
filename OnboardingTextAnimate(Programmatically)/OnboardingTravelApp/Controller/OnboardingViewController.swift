//
//  OnboardingViewController.swift
//  OnboardingTravelApp
//
//  Created by Lucky on 10.10.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    var items: [OnboardModel] = []
    var currentPage: Int = 0
    
    //MARK: - UI-el
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()

    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Test test testTest test testTest test test"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = UIImage(named: "image0")
        image.contentMode = .scaleAspectFill
        return image
    }()

    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = items.count
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    private let transperencyView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    lazy var gesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        gesture.delegate = self
        return gesture
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlaceholderItems()
        setupUI()
        setupConstraints()
        setupScreen(index: currentPage)
        updateBackgroundImage(index: currentPage)
        setupViews()
    }
    
    //MARK: - Actions
    @objc
    func handleTapAnimation(_ sender: UITapGestureRecognizer) {
        // The tap on the screen will enable title animation
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0,
                           usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5,
                           options: .curveEaseInOut, animations: {
                            
                            self.titleLabel.alpha = 0.8
                            self.titleLabel.transform = CGAffineTransform(translationX: -20,
                                                                          y: 0)
                           }) { _ in
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.titleLabel.alpha = 0.8
                    self.titleLabel.transform = CGAffineTransform(translationX: 0,
                                                                  y: -550)
                }, completion: nil)
            }
        }
        // The next animation is detail animation
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.detailLabel.alpha = 0.8
                self.detailLabel.transform = CGAffineTransform(translationX: -20,
                                                               y: 0)
            }) { _ in
                
                if self.currentPage < self.items.count - 1 {
                    self.updateBackgroundImage(index: self.currentPage + 1)
                }
               
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.detailLabel.alpha = 0.8
                    self.detailLabel.transform = CGAffineTransform(translationX: 0,
                                                                   y: -750)
                }) { _  in
                    
                    self.currentPage += 1
                    if self.isOverLastItem() {
                        let vc = UINavigationController(rootViewController: MainViewController())
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    } else {
                        self.setupScreen(index: self.currentPage)
                    }
                }
            }
        }
    }
    
    //MARK: - Helpers
    
    func setupPlaceholderItems() {
        items = OnboardModel.placeholderItems
    }
    
    func setupViews() {
        transperencyView.backgroundColor = .init(white: 0.08, alpha: 0.5)
    }
    
    func updateBackgroundImage(index: Int) {
        guard let image = items[index].bgImage else { return }
        
        DispatchQueue.main.async {
            UIView.transition(with: self.imageView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.imageView.image = image },
                              completion: nil)
        }
    }
    
    func isOverLastItem() -> Bool {
        return currentPage == self.items.count
    }
    
    func setupScreen(index: Int) {
        titleLabel.text = items[index].title
        detailLabel.text = items[index].detail
        pageControl.currentPage = index
        
        [titleLabel, detailLabel].forEach({
            $0.transform = .identity;
            $0.alpha = 1.0
        })
    }
    
    func setupUI() {
        view.addGestureRecognizer(gesture)
        
        [imageView,transperencyView, pageControl].forEach {
            view.addSubview($0);
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [titleLabel, detailLabel].forEach {
            transperencyView.addSubview($0);
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        
        // transperencyView
        NSLayoutConstraint.activate([
            transperencyView.topAnchor.constraint(equalTo: view.topAnchor),
            transperencyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            transperencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            transperencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 280),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250)
        ])
        
        // detailLabel
        NSLayoutConstraint.activate([
            detailLabel.widthAnchor.constraint(equalToConstant: 325),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17)
        ])
        
        // imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        // pageControl
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 350)
        ])
    }
}

extension OnboardingViewController: UIGestureRecognizerDelegate {}
