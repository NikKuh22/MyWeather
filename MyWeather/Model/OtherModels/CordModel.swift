//
//  Cord.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import Foundation

struct CordModel: Decodable {
    var lon: Double
    var lat: Double
    
    init() {
        self.lon = 0.0
        self.lat = 0.0
    }
}
