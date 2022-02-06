//
//  BeerListCell.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/31.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class BeerListCell : UITableViewCell {
    
    let numberLabel = UILabel()
    let beerImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImageView, nameLabel, numberLabel, descriptionLabel].forEach{ contentView.addSubview($0) }
        
        //콘텐츠 비율을 유지하여 View 크기에 맞게 확장하는 옵션, 남은 영역은 투명하다.
        beerImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        numberLabel.font = .systemFont(ofSize: 13)
        numberLabel.textColor = UIColor(.yellow)
        
        descriptionLabel.numberOfLines = 0
        
        //투명도 설정
        descriptionLabel.textColor = descriptionLabel.textColor.withAlphaComponent(0.5)
//        descriptionLabel.lineBreakMode = .byWordWrapping
        
        beerImageView.snp.makeConstraints {
            $0.centerX.equalTo(0)
            $0.leading.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(90)
            $0.height.equalTo(200)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(numberLabel.snp.bottom)
        }
        
        numberLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing)
            $0.top.equalTo(beerImageView.snp.top
            )
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing)
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(with beer : Beer) {
        var imageURL = URL(string: beer.imageURL ?? "")
        let image = UIImage(named: "1613805137738")
        beerImageView.kf.setImage(with: imageURL, placeholder: image)
        nameLabel.text = beer.name ?? "No name"
        numberLabel.text = String(beer.id)
        descriptionLabel.text = beer.description
        
        //cell 의 indicator 표시 추가
        accessoryType = .disclosureIndicator // 오른쪽에 > 모양 만들기
        selectionStyle = .none
    }
}
