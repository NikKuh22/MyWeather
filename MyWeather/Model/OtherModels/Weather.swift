//
//  Weather.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import Foundation


struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    init() {
        self.id = 0
        self.main = ""
        self.description = ""
        self.icon = ""
    }
}
