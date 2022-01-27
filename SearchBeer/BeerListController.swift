//
//  BeerListController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/26.
//

import Foundation
import UIKit
import SnapKit


class BeerListController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    let items : [String] = ["aa", "bb", "cc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        
        [tableView].forEach{ view.addSubview($0)}
        
        self.title = "Beer List"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Beer List"
        
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(.snp.bottom)
//
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
}
