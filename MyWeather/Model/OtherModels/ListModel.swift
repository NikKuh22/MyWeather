//
//  ListModel.swift
//  MyWeather
//
//  Created by Никита Анонимов on 20.08.2022.
//

import Foundation

struct ListModel: Decodable {
    var dt: Int
    var main: MainModel
    var weather: [WeatherModel]
    var clouds: CloudsModel
    var wind: WindModel
    var visibility: Int
    var pop: Double
    var dt_txt: String
    
    init() {
        self.dt = 0
        self.main = MainModel()
        self.weather = [WeatherModel]()
        self.clouds = CloudsModel()
        self.wind = WindModel()
        self.visibility = 0
        self.pop = 0.0
        self.dt_txt = ""
    }
}
