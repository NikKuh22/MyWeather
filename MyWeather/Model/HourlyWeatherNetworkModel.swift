//
//  WeatherForFiveDaysNetworkModel.swift
//  MyWeather
//
//  Created by Никита Анонимов on 16.08.2022.
//

import UIKit

struct List: Decodable {
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

struct City: Decodable {
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

struct HourlyWeatherNetworkModel: Decodable {
    var cod: String
    var message: Int
    var list: [List]
    var city: City
    
    init() {
        self.cod = ""
        self.message = 0
        self.list = [List]()
        self.city = City()
    }
    
}
