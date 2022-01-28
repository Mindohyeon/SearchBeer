//
//  RandomController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/28.
//

import Foundation
import UIKit

class RandomController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Random Beer"
    }
}
