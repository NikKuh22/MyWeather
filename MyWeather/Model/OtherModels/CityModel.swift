//
//  CityModel.swift
//  MyWeather
//
//  Created by Никита Анонимов on 20.08.2022.
//

import Foundation

struct CityModel: Decodable {
    var id: Int
    var name: String
    var coord: CordModel
    var country: String
    var population: Int
    var timezone: Int
    var sunrise: Int
    var sunset: Int
    
    init() {
        self.id = 0
        self.name = ""
        self.coord = CordModel()
        self.country = ""
        self.population = 0
        self.timezone = 0
        self.sunrise = 0
        self.sunset = 0
    }
}
