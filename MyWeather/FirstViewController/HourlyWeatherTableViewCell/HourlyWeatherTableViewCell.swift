//
//  SecondCustomViewCell.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import UIKit

final class HourlyWeatherTableViewCell: UITableViewCell {
    
    var weatherArrayModel = [ListModel]()
    var network = Network()
    
    @IBOutlet var horizontalCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        horizontalCollectionView.dataSource = self
        
        horizontalCollectionView.register(UINib(nibName: "HorizontalCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HorizontalCollectionViewCell")
        
        network.fetchForecast { forecast in
            self.weatherArrayModel = forecast.list
            self.horizontalCollectionView.reloadData()
            }
        
    }

}

extension HourlyWeatherTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArrayModel.count - 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCollectionViewCell", for: indexPath) as! HorizontalCollectionViewCell
       
        cell.configCollectionViewCell(model: weatherArrayModel[indexPath.row])
        return cell
    }
}
