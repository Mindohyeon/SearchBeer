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
        
        var SearchViewNC = UINavigationController(rootViewController: SearchVC)
        var BeerListNC = UINavigationController(rootViewController: BeerListVC)
        
        SearchViewNC.tabBarItem.title = "Search ID"
        BeerListNC.tabBarItem.title = "Beer List"
        
        
        self.setViewControllers([ BeerListNC, SearchViewNC], animated: false)
        
        guard let items = self.tabBar.items else {return}
        
        let images = ["1.circle", "2.circle"]
        
        for x in 0...1 {
            items[x].image = UIImage(systemName: images[x])
        }
    
    }
    
}
