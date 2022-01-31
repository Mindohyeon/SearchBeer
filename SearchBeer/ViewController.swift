//
//  ViewController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/31.
//

import Foundation
import UIKit

class ViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.punkapi.com/v2/beers?brewed_before=11-2012&abv_gt=6"
        let url = URL(string: urlString)

        guard url != nil else {
            return
        }
        
        let dataTast = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do {
                let BeerModel = try decoder.decode(BeerModel.self, from: data!)
                    print(BeerModel)
            }
                catch {
                    print("Error in JSON parsing")
                }
            
            }
        }
        dataTast.resume()
    }
}
