//
//  NetworkModel.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import UIKit

struct TodayWeatherNetworkModel: Decodable {
    var cord: Cord?
    var weather: [Weather]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    init() {
        self.cord = Cord()
        self.weather = [Weather]()
        self.base = ""
        self.main = Main()
        self.visibility = 0
        self.wind = Wind()
        self.clouds = Clouds()
        self.dt = 0
        self.sys = Sys()
        self.timezone = 0
        self.id = 0
        self.name = "Location"
        self.cod = 0
    }
}
