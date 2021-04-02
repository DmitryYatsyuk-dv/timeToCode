//
//  PopupVC.swift
//  ExamplePop-up
//
//  Created by Lucky on 02.04.2021.
//

import UIKit

class PopupCV: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var popupView: UIView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - @IBAction
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
