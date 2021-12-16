//
//  OnboardingController.swift
//  OnboardingFashionApp(Programmatically)
//
//  Created by Lucky on 11.10.2021.
//

import UIKit
//
//struct OnboardingModel {
//    let title: String
//    let detail: String
//    let image: UIImage?
//}

class OnboardingController: UIViewController {
    
    //MARK: - Properties
    
    private let customView = CustomView()
    private var imageViews = [UIImageView]()
    
    private var items: [OnboardingModel] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    //MARK: - Lifecycle
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupPlaceholderItems()
        setupViews()
        setupPageControl()
        setupNextButton()
        setupImageView()
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
    
    func setupPlaceholderItems() {
        items = OnboardingModel.placeholderItems
    }
    
    func setupImageView() {
        items.forEach { item in
            let imageView = UIImageView(image: item.image)

            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.alpha = 0.0
            
            view.addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -282),
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            imageViews.append(imageView)
        }
        
        imageViews.first?.alpha = 1.0
        view.bringSubviewToFront(collectionView)
    }

    func setupNextButton() {
        customView.handlerNextButton = {
            let nextRow = self.getCurrentIndex() + 1
            let nextIndexPath = IndexPath(row: nextRow, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
            self.showItem(at: nextRow)
        }
    }
    
    func setupPageControl() {
        customView.pageControl.numberOfPages = items.count
    }
    
    func showItem(at index: Int) {
        customView.pageControl.currentPage = index
        let isHide = index == items.count - 1
        customView.nextButton.isHidden = isHide
    }
    
    func getCurrentIndex() -> Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let index = getCurrentIndex()
        let fadeInAlpha = (x - collectionViewWidth * CGFloat(index)) / collectionViewWidth
        let fadeOutAlpha = CGFloat(1 - fadeInAlpha)
        
        let checkedIndex = (index < items.count - 1)
        guard checkedIndex else { return }
        imageViews[index].alpha = fadeOutAlpha
        imageViews[index + 1].alpha = fadeInAlpha
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = getCurrentIndex()
        showItem(at: index)
    }
    
    var collectionViewWidth: CGFloat {
        return collectionView.frame.size.width
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        
        view.addSubview(collectionView)
        
        collectionView.register(CustomCollectionViewCell.self,
                                forCellWithReuseIdentifier: CustomCollectionViewCell.reuseID)
//        collectionView.backgroundColor = .systemPink
        
        setConstraints()
    }
    
    //MARK: - setConstraints
    func setConstraints() {

        // CollectionView
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
}

//MARK: - UICollectionViewDelegate
extension OnboardingController: UICollectionViewDelegate {}

//MARK: - UICollectionViewDataSource
extension OnboardingController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseID, for: indexPath) as! CustomCollectionViewCell
        
        let shouldShow = indexPath.item == items.count - 1
        cell.showSkipButton(isShow: shouldShow)
        let item = items[indexPath.item]
        
//        cell.delegate = self
        
        cell.configureUI(with: item)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//extension OnboardingController: CustomCollectionViewCellDelegate {
//    func didTapSkipButton() {
//        print("DEBUG: tappppppped!!!!")
//    }
//}
