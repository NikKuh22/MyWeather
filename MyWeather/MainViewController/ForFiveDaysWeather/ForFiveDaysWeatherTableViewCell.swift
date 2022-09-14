//
//  ForFiveDaysWeatherTableViewCell.swift
//  MyWeather
//
//  Created by Никита Анонимов on 16.08.2022.
//

import UIKit

final class ForFiveDaysWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var weatherImageView: UIImageView!
    @IBOutlet private var tempLabel: UILabel!
    
    func configureWeatherForFiveDays(modelHightTemp: ListModel, modelLowTemp: ListModel) {
        let dateFormater = DateFormatter()
        tempLabel.text = "\(Int(modelHightTemp.main.temperature))°/\(Int(modelLowTemp.main.temperature))°"
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:mm"
        let dateFromNetwork = dateFormater.date(from: modelLowTemp.dt_txt)
        let date = dateFromNetwork?.get(.day) ?? 0
        let month = dateFromNetwork?.get(.month) ?? 0
        if month <= 9 {
            dayLabel.text = "\(date).0\(month)"
        } else {
            dayLabel.text = "\(date).\(month)"
        }
        weatherImageView.image = modelHightTemp.weather.first?.main.image
    }
}
