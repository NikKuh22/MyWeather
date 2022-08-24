//
//  HorizontalCollectionViewCell.swift
//  MyWeather
//
//  Created by Никита Анонимов on 18.08.2022.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    let dateFormater = DateFormatter()

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCollectionViewCell(model: ListModel) {
        tempLabel.text = "\(Int(model.main.temp))°"
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:mm"
        let dateFromNetwork = dateFormater.date(from: model.dt_txt)
        let hour = dateFromNetwork?.get(.hour) ?? 0
        timeLabel.text = "\(hour):00"
        weatherImageView.image = model.weather.first?.main.image
        }
    }

