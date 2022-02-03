//
//  BeerDetailVIewController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/02/02.
//

import Foundation
import UIKit
import Kingfisher

class BeerDetailViewController : UITableViewController {
    
    var beer : Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = beer?.name ?? "No name"

        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)

    }
    
}
