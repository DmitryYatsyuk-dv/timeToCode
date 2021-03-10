//
//  MenuViewController.swift
//  aSlideInTransition
//
//  Created by Lucky on 23.02.2021.
//

import UIKit

enum MenuType: Int {
    case house
    case camera
    case profile
    case todo
    case settings
    case info
}

class MenuViewController: UITableViewController {

    var didTapMenuType: ((MenuType) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            print("DEBUG: Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }
}
