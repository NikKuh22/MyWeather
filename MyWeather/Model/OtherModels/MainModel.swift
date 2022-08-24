//
//  Main.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import Foundation

struct MainModel: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
    var sea_level: Int?
    var grnd_level: Int?
    
    init() {
        self.temp = 0.0
        self.feels_like = 0.0
        self.temp_min = 0.0
        self.temp_max = 0.0
        self.pressure = 0
        self.humidity = 0
        self.sea_level = 0
        self.grnd_level = 0
    }
}
