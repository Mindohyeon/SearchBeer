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
        
        let searchBar = UISearchBar()
        
        [searchBar].forEach { view.addSubview($0)}
        
        
        self.view.backgroundColor = .white
        
        self.title = "Search ID"
        searchBar.placeholder = "Search"
        
        self.navigationItem.titleView = searchBar
        
    }


}

