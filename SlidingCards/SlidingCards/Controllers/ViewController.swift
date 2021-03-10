//
//  ViewController.swift
//  SlidingCards
//
//  Created by Lucky on 23.02.2021.
//

import UIKit
import CardSlider
struct Item: CardSliderItem {
    
    var image: UIImage
    var rating: Int?
    var title: String
    var subtitle: String?
    var description: String?
}

class ViewController: UIViewController {
    
    var data = [Item]()
    
    @IBOutlet var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        data.append(Item(image: #imageLiteral(resourceName: "Jack"), rating: nil,
                         title: "Jack", subtitle: "Akita Inu" ,
                         description: "I am on my own! But you can feed me .. Although you have no options"))

        data.append(Item(image: #imageLiteral(resourceName: "dogOne"), rating: nil,
                         title: "Cherry Sock", subtitle: "I do not know this breed" ,
                         description: "I'm Jack's friend, we have a gang, so you have to feed me too!"))

        data.append(Item(image: #imageLiteral(resourceName: "dogTwo"), rating: nil,
                         title: "Slippery Bob", subtitle: "Bulldog" ,
                         description: "My name is Bob, you have already met my friends! Check out my hat and give me a paw!"))
        
        data.append(Item(image: #imageLiteral(resourceName: "dogThree"), rating: nil,
                         title: "Jack", subtitle: "What??!o_O]" ,
                         description: "Guys, who is this in our ranks?"))

        data.append(Item(image: #imageLiteral(resourceName: "catOne"), rating: nil,
                         title: "Teabagger", subtitle: "This is a cat" ,
                         description: "Salute slobbering! Have an idea where to get food, who is with me?"))

        data.append(Item(image: #imageLiteral(resourceName: "dogFife"), rating: nil,
                         title: "Rasty", subtitle: "La Familia" ,
                         description: "With cats - we have no business! Get out! Gow-gow"))
        
        myButton.backgroundColor = .link
        myButton.setTitleColor(.white, for: .normal)
    }

    @IBAction func didTapButton() {
        // Present the card slider
        let vc = CardSliderViewController.with(dataSource: self)
        vc.title = "Welcome!"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

}

extension ViewController: CardSliderDataSource {
    func item(for index: Int) -> CardSliderItem {
        data[index]
    }
    
    func numberOfItems() -> Int {
        return data.count
    }
    
    
}

