//
//  Clouds.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import Foundation

struct Clouds: Decodable {
    var all: Int
    
    init() {
        self.all = 0
    }
}
