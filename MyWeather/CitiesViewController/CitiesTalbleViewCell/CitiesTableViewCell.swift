//
//  CitiesTableViewCell.swift
//  MyWeather
//
//  Created by Никита Анонимов on 23.08.2022.
//

import UIKit

final class CitiesTableViewCell: UITableViewCell {

    @IBOutlet private var nameCityLabel: UILabel!

    func config(model: CityLocationModel) {
        self.nameCityLabel.text = "• \(model.name)"
    }
    
}
