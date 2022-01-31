//
//  ViewController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/25.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        let searchController = UISearchController(searchResultsController: nil)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search BY ID"
        
        //UISearchBar 내의 텍스트가 변경되는 것을 알린다.
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    

}
    
