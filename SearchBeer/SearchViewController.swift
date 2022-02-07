//
//  ViewController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/25.
//

import UIKit
import SnapKit
import CoreMedia

class SearchViewController: UIViewController {
    
    var tableView : UITableView!
    
    var SearchData = [Beer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearchController()
        setupTableView()
        
        //UISearchBar 내의 텍스트가 변경되는 것을 알린다.
//        searchController.searchResultsUpdater = self
        
    }
    
    func setupSearchController() {
        self.view.backgroundColor = .white
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
    
        searchController.hidesNavigationBarDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search BY ID"
        
    }
    
}


extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
    }
}
extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = SearchData[indexPath.row].name
        return cell
    }
    
    
}

