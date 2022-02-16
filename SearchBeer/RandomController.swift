//
//  RandomController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/28.
//

import Foundation
import UIKit
import SnapKit

class RandomController : UIViewController {
    var dataTasks = [URLSessionTask]()
    
    var beerList : [Beer]?
    
    var imageView = UIImageView()
    var numberView = UILabel()
    var nameView = UILabel()
    var descriptionView = UILabel()
    var randomButton = UIButton()
    var headerView = UIImageView()
    var imageURL = URL(string: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Random Beer"
        
        numberView.textColor = .systemYellow
        
        descriptionView.numberOfLines = 0
        descriptionView.font = .systemFont(ofSize: 13)
        descriptionView.textColor = descriptionView.textColor.withAlphaComponent(0.5)
        
        randomButton.backgroundColor = .orange
        randomButton.setTitle("Roll Random", for: .normal)
        randomButton.setTitleColor(.white, for: .normal)
        randomButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        //Method 등록
        randomButton.addTarget(self, action: #selector(onTabButton), for: .touchUpInside)
        
        headerView.contentMode = .scaleAspectFit
        
        [headerView, numberView, nameView, descriptionView, randomButton].forEach { view.addSubview($0)}
        headerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(150)
            $0.width.equalTo(200)
            $0.height.equalTo(200)
        }
        
        numberView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            
        }
        
        nameView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(numberView.snp.bottom).offset(10)
        }
        
        descriptionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(5)
        }
        
        randomButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(140)
        
        
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        random()

        imageURL = URL(string: beerList?[0].imageURL ?? "")
        headerView.kf.setImage(with: imageURL, placeholder: UIImage(named: "1613805137738"))
        
        numberView.text = String(describing: beerList?[0].id ?? 0)
        nameView.text = beerList?[0].name
        descriptionView.text = beerList?[0].description
        print("beerList : \(beerList)")
        print("beerList.imageURL : \(beerList?[0].imageURL)")
    }
    
    @objc
    func onTabButton() {
        print("Tabbed")
        random()
        viewWillAppear(true)
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
            
//            self?.beerDetailView.beer = self?.beerList?[0]
//            print("RandomController - beerList : \(self?.beerList?[0])")
            
        }
        
        dataTask.resume()
        
    }
}
