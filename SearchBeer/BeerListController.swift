//
//  BeerListController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/26.
//

import Foundation
import UIKit
import SnapKit


class BeerListController : UITableViewController{
    
    var beerList =  [Beer]()
    var currentpage = 1
    var dataTask = [URLSession]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // cell register
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 200
        
        //pagination
        tableView.prefetchDataSource = self
        
    }
}

extension BeerListController : UITableViewDataSourcePrefetching {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath)
                as? BeerListCell else { return UITableViewCell() }
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        
        return cell
    }
    
    //BeerDetailViewController 와 연결
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //선택한 beer 를 selectedBeer 로 받기
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        //BeerDetailViewController 로 이동
        detailViewController.beer = selectedBeer
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentpage != 1 else { return }
        indexPaths.forEach{
            if($0.row + 1) / 25 + 1 == currentpage {
                fetchBeer(of : currentpage)
            }
        }
        
    }
    
}

extension BeerListController {
    func fetchBeer(of Page : Int) {
        
    }
}


//        bold 체로 하면서 size 는 30
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
//        navigation 자리를 없앰
//        navigationController?.isNavigationBarHidden = true
               
//    // cell 의 개수
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 30
//    }
//
//    // cell 이 tap 되었을 때
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("cell tapped")
//    }
