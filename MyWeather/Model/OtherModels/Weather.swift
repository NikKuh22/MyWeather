//
//  Weather.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import Foundation
import UIKit


enum MainWeather: String, Decodable {
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "Snow"
    case mist = "Mist"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
    case clear = "Clear"
    case clouds = "Clouds"
    
    var image: UIImage? {
        switch self {
        case .thunderstorm: return UIImage(systemName: "cloud.bolt")
        case .drizzle: return UIImage(systemName: "cloud.drizzle")
        case .rain: return UIImage(systemName: "cloud.rain")
        case .snow: return UIImage(systemName: "cloud.snow")
        case .mist: return UIImage(systemName: "humidity")
        case .clear: return UIImage(systemName: "sun.max")
        case .clouds: return UIImage(systemName: "cloud")
        case .smoke: return UIImage(systemName: "humidity")
        case .haze: return UIImage(systemName: "humidity")
        case .fog: return UIImage(systemName: "humidity")
        case .sand: return UIImage(systemName: "humidity")
        case .dust: return UIImage(systemName: "humidity")
        case .ash: return UIImage(systemName: "humidity")
        case .squall: return UIImage(systemName: "humidity")
        case .tornado: return UIImage(systemName: "humidity")
        }
    }
}

struct Weather: Decodable {
    var id: Int
    var main: MainWeather
    var description: String
    var icon: String
    
    init() {
        self.id = 0
        self.main = MainWeather.drizzle
        self.description = ""
        self.icon = ""
    }
}
