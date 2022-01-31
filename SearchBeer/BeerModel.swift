//
//  Json.swift
//  SearchBeer
//
//  Created by 민도현 on 2022/01/30.
//

import Foundation

struct BeerModel : Codable {
    
    // Apple 은 카멜케이스 사용을 권장하기 때문에 swift 에서 카멜케이스를 사용하는 것은 강제된다.
//    var beerName : String
//    var ids : String
//
//    enum CodingKeys : String, CodingKey {
//        case ids
//        case beerName = "beer_name"
//    }
    
    var id : Int
    var name : String
}

