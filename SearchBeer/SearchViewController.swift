//
//  ViewController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/25.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    
    var SearchData : [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupSearchController()
        
        //UISearchBar 내의 텍스트가 변경되는 것을 알린다.
//        searchController.searchResultsUpdater = self
        
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search BY ID"
        
    }
    
}


extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
    }
}
