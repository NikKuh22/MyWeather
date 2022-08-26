//
//  HorizontalCollectionViewCell.swift
//  MyWeather
//
//  Created by Никита Анонимов on 18.08.2022.
//

import UIKit

final class HorizontalCollectionViewCell: UICollectionViewCell {
    
    let dateFormater = DateFormatter()

    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var tempLabel: UILabel!
    @IBOutlet private var weatherImageView: UIImageView!
    
    
    func configCollectionViewCell(model: ListModel) {
        tempLabel.text = "\(Int(model.main.temperature))°"
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:mm"
        let dateFromNetwork = dateFormater.date(from: model.dt_txt)
        let hour = dateFromNetwork?.get(.hour) ?? 0
        timeLabel.text = "\(hour):00"
        weatherImageView.image = model.weather.first?.main.image
        }
    }


