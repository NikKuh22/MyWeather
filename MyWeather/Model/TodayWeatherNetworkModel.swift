//
//  NetworkModel.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import UIKit

struct TodayWeatherNetworkModel: Decodable {
    var cord: CordModel?
    var weather: [WeatherModel]
    var base: String
    var main: MainModel
    var visibility: Int
    var wind: WindModel
    var clouds: CloudsModel
    var dt: Int
    var sys: SysModel
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    init() {
        self.cord = CordModel()
        self.weather = [WeatherModel]()
        self.base = ""
        self.main = MainModel()
        self.visibility = 0
        self.wind = WindModel()
        self.clouds = CloudsModel()
        self.dt = 0
        self.sys = SysModel()
        self.timezone = 0
        self.id = 0
        self.name = "Location"
        self.cod = 0
    }
}
