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
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
//        titleLabel.text =  "Beer List"
        //bold 체로 하면서 size 는 30
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Beer List"
        
        
        [tableView, titleLabel].forEach{ view.addSubview($0)}
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
//        navigationController?.isNavigationBarHidden = true
        
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "BeerList"
               
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        titleLabel.snp.makeConstraints {
//            $0.centerY.equalTo(100)
//            $0.leadingMargin.equalTo(10)
//
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Cell : \(indexPath.row)"
        
        return cell
    }
    
    // cell 의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    // cell 이 tap 되었을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell tapped")
    }
    
}
