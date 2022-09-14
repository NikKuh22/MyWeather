//
//  DateExtension.swift
//  MyWeather
//
//  Created by Никита Анонимов on 14.09.2022.
//

import Foundation

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
