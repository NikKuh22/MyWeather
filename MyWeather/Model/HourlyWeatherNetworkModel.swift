//
//  WeatherForFiveDaysNetworkModel.swift
//  MyWeather
//
//  Created by Никита Анонимов on 16.08.2022.
//

import UIKit

struct HourlyWeatherNetworkModel: Decodable {
    var cod: String
    var message: Int
    var list: [ListModel]
    var city: CityModel
}
