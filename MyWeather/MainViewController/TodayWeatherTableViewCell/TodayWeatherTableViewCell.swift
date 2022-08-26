//
//  CustomTableViewCell.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import UIKit
protocol TodayWeatherTableViewCellDelegate: AnyObject {
    func presentViewController()
}

final class TodayWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var tempLabel: UILabel!
    @IBOutlet private var humidityLabel: UILabel!
    @IBOutlet private var windLabel: UILabel!
    
    weak var delegate: TodayWeatherTableViewCellDelegate?
    
    @IBOutlet private var weatherImage: UIImageView!
        
    @IBAction private func presentCities(_ sender: UIButton) {
        delegate?.presentViewController()
    }
    
    func configureTodayWeather(model: TodayWeatherNetworkModel) {
        cityLabel.text = model.name
        tempLabel.text = "\(Int(model.main.temperature))°"
        humidityLabel.text = "\(model.main.humidity)%"
        windLabel.text = "\(model.wind.speed)m/s"
        weatherImage.image = model.weather.first?.main.image
    }
    
}

