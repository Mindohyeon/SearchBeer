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
    
    //Beer 들 받아오기
    var beerList =  [Beer]()
    //한 번 불러온 데이터는 다시 받지 않기 위함
    var dataTasks = [URLSessionTask]()
    //현재 페이지를 첫번째 페이지로 지정
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "BeerList"
        
        // cell register
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 130
        
        //pagination
        tableView.prefetchDataSource = self
        
        fetchBeer(of: currentPage)
        
    }
}

extension BeerListController : UITableViewDataSourcePrefetching {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("beerList : \(beerList.count)")
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath)
                as? BeerListCell else { return UITableViewCell() }
        
        //cell 에 Data 넣기
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
        
        self.show(detailViewController, sender: nil)
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
              //요청된 적 없는 url 인지 확인
                dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil
        else { return }
        var request = URLRequest(url: url)
        //get 으로 설정
        request.httpMethod = "GET"
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                      print("Error!!")
                      return
                  }
            
            //response의 statusCode 별 대처
            switch response.statusCode {
            case(200...299):  //성공, 받아온 beers 데이터를 beerList 에 추가, 다음 페이지로 이동
                self?.beerList += beers
                self?.currentPage += 1
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            default:
                print("""
                    Error : Error \(response.statusCode)
                    Response : \(response)
                """)
            }
            
        }
        
        dataTask.resume()
        
        //실행했던 거 다시 실행시키지 않기 위해서
        dataTasks.append(dataTask)
    }
}


//        bold 체로 하면서 size 는 30
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
//        navigation 자리를 없앰
//        navigationController?.isNavigationBarHidden = true
