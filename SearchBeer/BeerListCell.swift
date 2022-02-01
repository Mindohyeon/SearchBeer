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
    
    let beerImageView = UIImageView()
    let nameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImageView, nameLabel].forEach{ contentView.addSubview($0) }
        
        beerImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.numberOfLines = 2
        
        beerImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(30)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(beerImageView.snp.centerY)
        }
    }
    
    func configure(with beer : Beer) {
        var imageURL = URL(string: beer.imageURL ?? "")
//        beerImageView.kf.setImage(with: imageURL, placeholder: )
        nameLabel.text = beer.name ?? "No name"
        
        //cell 의 indicator 표시 추가
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}
