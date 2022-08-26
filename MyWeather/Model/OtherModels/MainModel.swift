//
//  Main.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import Foundation

struct MainModel: Decodable {
    var temperature: Double
    var feelsLike: Double
    var temperatureMin: Double
    var temperatureMax: Double
    var pressure: Int
    var humidity: Int
    var seaLevel: Int?
    var groundLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
    }
    
    init() {
        self.temperature = 0.0
        self.feelsLike = 0.0
        self.temperatureMin = 0.0
        self.temperatureMax = 0.0
        self.pressure = 0
        self.humidity = 0
        self.seaLevel = 0
        self.groundLevel = 0
    }
}
