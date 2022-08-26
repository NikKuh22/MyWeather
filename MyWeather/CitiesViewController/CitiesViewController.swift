//
//  CitiesViewController.swift
//  MyWeather
//
//  Created by Никита Анонимов on 23.08.2022.
//

import UIKit

protocol CitiesViewControllerDelegate: AnyObject {
    func citiesViewControllerDidSelect(
        _ citiesViewController: CitiesViewController,
        latitude: Double,
        longitude: Double
    )
}

final class CitiesViewController: UIViewController {
    private let citiesModel: [CityLocationModel] = [
        CityLocationModel(name: "Kharkiv", lat: 49.9808, lon: 36.2527),
        CityLocationModel(name: "Kyiv", lat: 50.4546600, lon: 30.5238000),
        CityLocationModel(name: "Odessa", lat: 46.48253, lon: 30.72331),
        CityLocationModel(name: "Lviv", lat: 49.8383, lon: 24.0232),
        CityLocationModel(name: "Zaporozhye", lat: 47.8229, lon: 35.1903),
        CityLocationModel(name: "Dnieper", lat: 48.4593, lon: 35.0387),
        CityLocationModel(name: "Vinnitsa", lat: 49.23308, lon: 28.46822),
        CityLocationModel(name: "Ivano-Frankivsk", lat: 48.9215, lon: 24.7097),
        CityLocationModel(name: "Mariupol", lat: 47.0951, lon: 37.5413),
        CityLocationModel(name: "Poltava", lat: 49.5937, lon: 34.5407),
        CityLocationModel(name: "Sumy", lat: 50.9216, lon: 34.8003),
        CityLocationModel(name: "Khmelnitsky", lat: 49.4216100, lon: 26.9965300),
        CityLocationModel(name: "Ternopil", lat: 49.5534, lon: 25.5892),
        CityLocationModel(name: "Kherson", lat: 46.6558, lon: 32.6178),
        CityLocationModel(name: "Mikolaev", lat: 46.9659, lon: 31.9974)
    ]
    
    @IBOutlet private var citiesTableView: UITableView!
    
    weak var delegate: CitiesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        
        citiesTableView.register(UINib(nibName: "CitiesTableViewCell", bundle: .main), forCellReuseIdentifier: "CitiesTableViewCell")
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        citiesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: "CitiesTableViewCell", for: indexPath) as! CitiesTableViewCell
        cell.config(model: citiesModel[indexPath.row])
        return cell
    }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = citiesModel[indexPath.row]
        delegate?.citiesViewControllerDidSelect(self, latitude: model.lat, longitude: model.lon)
        dismiss(animated: true)
    }
}
