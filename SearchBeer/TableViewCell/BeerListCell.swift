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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImageView, nameLabel, numberLabel].forEach{ contentView.addSubview($0) }
        
        //콘텐츠 비율을 유지하여 View 크기에 맞게 확장하는 옵션, 남은 영역은 투명하다.
        beerImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.numberOfLines = 2
        
        numberLabel.textColor = UIColor(.yellow)
        
        beerImageView.snp.makeConstraints {
            $0.centerX.equalTo(0)
            $0.leading.top.bottom.equalToSuperview().inset(30)
            $0.width.equalTo(200)
            $0.height.equalTo(200)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(numberLabel.snp.bottom)
        }
        
        numberLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing)
            $0.top.equalTo(beerImageView.snp.top
            )
        }
    }
    
    func configure(with beer : Beer) {
        var imageURL = URL(string: beer.imageURL ?? "")
        let image = UIImage(named: "1613805137738")
        beerImageView.kf.setImage(with: imageURL, placeholder: image)
        nameLabel.text = beer.name ?? "No name"
        numberLabel.text = String(beer.id)
        
        //cell 의 indicator 표시 추가
        accessoryType = .disclosureIndicator // 오른쪽에 > 모양 만들기
        selectionStyle = .none
    }
}
