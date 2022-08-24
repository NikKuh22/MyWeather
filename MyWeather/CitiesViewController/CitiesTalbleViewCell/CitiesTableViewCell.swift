//
//  CitiesTableViewCell.swift
//  MyWeather
//
//  Created by Никита Анонимов on 23.08.2022.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {

    @IBOutlet var nameCityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(model: CitiesModel) {
        self.nameCityLabel.text = "• \(model.name)"
    }
    
}
