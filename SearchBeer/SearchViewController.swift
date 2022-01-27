//
//  ViewController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/25.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        let searchBar = UISearchBar()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search BY ID"
        
        [searchBar].forEach { view.addSubview($0)}

        searchBar.placeholder = "Search"
        
//        self.navigationItem.titleView = searchBar
        
        
        
    }


}

