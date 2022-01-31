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
        
        let SearchVC = SearchViewController()
        let BeerListVC = BeerListController()
        let RandomVC = RandomController()
        
        let SearchViewNC = UINavigationController(rootViewController: SearchVC)
        let BeerListNC = UINavigationController(rootViewController: BeerListVC)
        let RandomNC = UINavigationController(rootViewController: RandomVC)
        
        SearchViewNC.tabBarItem.title = "Search ID"
        BeerListNC.tabBarItem.title = "Beer List"
        RandomNC.tabBarItem.title = "Random"
        
        
        self.setViewControllers([ BeerListNC, SearchViewNC, RandomNC], animated: false)
        
        guard let items = self.tabBar.items else {return}
        
        let images = ["1.circle", "2.circle", "3.circle"]
        
        for x in 0...2 {
            items[x].image = UIImage(systemName: images[x])
        }
    
    }
    
}
