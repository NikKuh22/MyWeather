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
}
