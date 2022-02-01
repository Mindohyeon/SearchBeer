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
    var currentPage = 1
    var dataTasks = [URLSession]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // cell register
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 200
        
        //pagination
        tableView.prefetchDataSource = self
        
        fetchBeer(of: currentPage)
        
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
        guard currentPage != 1 else { return }
        indexPaths.forEach{
            if($0.row + 1) / 25 + 1 == currentPage {
                self.fetchBeer(of : currentPage)
            }
        }
        
    }
    
}

extension BeerListController {
    func fetchBeer(of Page : Int) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(Page)"),
            
                dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil
        else { return }
        var request = URLRequest(url: url)
        //get 으로 설정
        request.httpMethod = "GET"
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                      print("Error!!")
                      return
                  }
            
            switch response.statusCode {
            case(200...299):  //성공, 받아온 beers 데이터를 beerList 에 추가, 다음 페이지로 이동
                self.beerList += beers
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            default:
                print("""
                    Error : Error \(response.statusCode)
                    Response : \(response)
                """)
            }
            
        }
        
        dataTask.resume()
        dataTasks.append(dataTask)
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
