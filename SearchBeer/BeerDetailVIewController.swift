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
            return beer?.foodPairing?.count ?? 0
            
        default:
            return 1
        }
    }
    
    //각 section 의 title 정하기
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "ID"
        case 1:
            return "Description"
        case 2:
            return "Brewer Tips"
        case 3:
            return "FoodPairing"
        default:
            return nil
        }
    }
    
    //받아온 beer 데이터 cell 에 넣어주기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "BeerListCell")
        
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = String(describing: beer?.id ?? 0)
            return cell
        case 1:
            cell.textLabel?.text = beer?.description ?? "설명 없음"
            return cell
        case 2:
            cell.textLabel?.text = beer?.brewersTips ?? "팁 없음"
            return cell
        case 3:
            cell.textLabel?.text = beer?.foodPairing?[indexPath.row]
            return cell
        default:
            return cell
        }
    }
    
}
