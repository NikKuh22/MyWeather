//
//  ForFiveDaysWeatherTableViewCell.swift
//  MyWeather
//
//  Created by Никита Анонимов on 16.08.2022.
//

import UIKit

final class ForFiveDaysWeatherTableViewCell: UITableViewCell {
    
    let dateFormater = DateFormatter()
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var imageLabel: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureWeatherForFiveDays(modelHightTemp: List, modelLowTemp: List) {
        tempLabel.text = "\(Int(modelHightTemp.main.temp))°/\(Int(modelLowTemp.main.temp))°"
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:mm"
        let dateFromNetwork = dateFormater.date(from: modelLowTemp.dt_txt)
        let date = dateFromNetwork?.get(.day) ?? 0
        let month = dateFromNetwork?.get(.month) ?? 0
        if month <= 9 {
            dayLabel.text = "\(date).0\(month)"
        } else {
            dayLabel.text = "\(date).\(month)"
        }
        imageLabel.image = modelHightTemp.weather.first?.main.image
    }
}

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
            return calendar.component(component, from: self)
        }
}
