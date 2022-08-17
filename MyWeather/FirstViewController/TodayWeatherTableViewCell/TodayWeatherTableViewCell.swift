//
//  CustomTableViewCell.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import UIKit

final class TodayWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    
    @IBOutlet var weatherImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureTodayWeather(model: TodayWeatherNetworkModel) {
        cityLabel.text = model.name
        tempLabel.text = "\(Int(model.main.temp))°"
        humidityLabel.text = "\(model.main.humidity)%"
        windLabel.text = "\(model.wind.speed)m/s"
    }
    
}

