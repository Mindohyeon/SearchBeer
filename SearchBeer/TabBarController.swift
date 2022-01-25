//
//  TabBarController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/25.
//

import Foundation
import UIKit

class TabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let beerListVC = BeerListVC()
        let searchIDVC = SearchIDVC()
        let randomVC = RandomVC()
        
        beerListVC.title = "Beer List"
        searchIDVC.title = "Search ID"
        randomVC.title = "Random"
        
        self.setViewControllers([beerListVC, searchIDVC, randomVC], animated: false)
        
        guard let items = self.tabBar.items else {return}
        
        let images = ["1.circle", "2.circle", "3.circle"]
        
        for x in 0...2 {
            items[x].image = UIImage(systemName: images[x])
        }
    }
    
}

class BeerListVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
    }
}

class SearchIDVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
    }
}

class RandomVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
    }
}
