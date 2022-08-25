//
//  Wind.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import Foundation

struct WindModel: Decodable {
    var speed: Double
    var deg: Int
    var gust: Double?
    
    init() {
        self.speed = 0.0
        self.deg = 0
        self.gust = 0.0
    }
}
