//
//  ViewController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/25.
//

import UIKit
import SnapKit
import CoreMedia

class SearchViewController: UIViewController {
    
    var tableView = UITableView()
    var filterArr : [String] = []
    var SearchData = [Beer]()
    var dataTasks = [URLSessionDataTask]()
    
    
    
    var currentPage = 1
    
    var a = ["a","b"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearchController()
        setupTableView()
        
        //UISearchBar 내의 텍스트가 변경되는 것을 알린다.
//        searchController.searchResultsUpdater = self
        
        [tableView].forEach{ view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    
    func setupSearchController() {
        self.view.backgroundColor = .white
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
    
//        searchController.hidesNavigationBarDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search BY ID"
        
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
}


extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }
//        self.filterArr = self.SearchData..map( {$0.filter { $0.localizedCaseInsensitiveContains(text)}})
        
        dump(searchController.searchBar.text)
    }
}

extension SearchViewController : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        indexPaths.forEach{
            if($0.row + 1) / 25 + 1 == currentPage {
//                self.fetchBeer(of : currentPage)
            }
        }
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("SearchData : \(SearchData.count)")

        fetchBeer(of: 1)
        return SearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("aaaaaaa")
        let cell = UITableViewCell()
        cell.textLabel?.text = SearchData[indexPath.row].name
        
        return cell
    }

}


extension SearchViewController {
    func fetchBeer(of Page : Int) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(Page)"),
              //요청된 적 없는 url 인지 확인
                dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil
        else { return }
        var request = URLRequest(url: url)
        print("aaa")
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
            
            //response의 statusCode 별 대처
            switch response.statusCode {
            case(200...299):  //성공, 받아온 beers 데이터를 beerList 에 추가, 다음 페이지로 이동
                self.SearchData += beers
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
        
        //실행했던 거 다시 실행시키지 않기 위해서
        dataTasks.append(dataTask)
    }
}

