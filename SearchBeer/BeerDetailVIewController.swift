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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let headerView = UIImageView(frame: frame)
        let imageURL = URL(string: beer?.imageURL ?? "")
        
        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: UIImage(named: "1613805137738"))
        
        tableView.tableHeaderView = headerView

    }
    
}

extension BeerDetailViewController {
    // section 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    //각 section 의 row 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return beer?.foodPairing.count ?? 0
            
        default:
            return 1
        }
    }
    
    
}
