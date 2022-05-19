//
//  RandomController.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/28.
//

import Foundation
import UIKit
import SnapKit
import Then

class RandomController : UIViewController {
    private var dataTasks = [URLSessionTask]()
    
    private var beerList : [Beer]?
    private var nameView = UILabel()
    private var imageView = UIImageView()
    
    private var numberView = UILabel().then {
        $0.textColor = .systemYellow
    }
    
    private var descriptionView = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 13)
        $0.textColor.withAlphaComponent(0.5)
    }
    
    private var randomButton = UIButton().then {
        $0.backgroundColor = .orange
        $0.setTitle("Roll Random", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.addTarget(self, action: #selector(onTabButton), for: .touchUpInside)
    }
    
    private var headerView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private var imageURL = URL(string: "")
    private var scrollV = UIScrollView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Random Beer"
        
        [scrollV, headerView, numberView, nameView, descriptionView, randomButton].forEach { view.addSubview($0)}
        scrollV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
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
        
        
        randomButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(50)
            $0.top.equalTo(nameView.snp.bottom).offset(12)
        }
        
        descriptionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(randomButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(5)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    @objc func onTabButton() {
        print("Tabbed")
        random()
        viewDidAppear(true)
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
