//
//  Sys.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import Foundation

struct SysModel: Decodable {
    var country: String
    var sunrise: Int
    var sunset: Int
    
    init() {
        self.country = ""
        self.sunrise = 0
        self.sunset = 0
    }
}
