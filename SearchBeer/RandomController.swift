//
//  RandomController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/28.
//

import Foundation
import UIKit

class RandomController : UITableViewController {
    var dataTasks = [URLSessionTask]()
    var beerDetailView = BeerDetailViewController()
    
    var beerList : [Beer]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Random Beer"
    
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        random()
        beerDetailView.beer = beerList?[0]
        print("beerList : \(beerList)")

        
        self.show(beerDetailView, sender: nil)
                
    }
}

extension RandomController {
    func random() {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers/random"),
                dataTasks.first(where: { $0.originalRequest?.url == url }) == nil
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let data = data,
                  let response = response as? HTTPURLResponse,
                  let beers = try? JSONDecoder().decode([Beer].self, from : data) else {
                      return 
                  }
            
            switch response.statusCode {
            case(200...299):
                print("beers : \(beers)")
                self?.beerList = beers
            
            
            default:
                print("""
                        Error : Error : \(response.statusCode)
                        Response : \(response)
                    """)
                  
            }
        }
        
        dataTask.resume()
        
    }
}
