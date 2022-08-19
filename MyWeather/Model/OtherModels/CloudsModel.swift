//
//  Clouds.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import Foundation

struct CloudsModel: Decodable {
    var all: Int
    
    init() {
        self.all = 0
    }
}
