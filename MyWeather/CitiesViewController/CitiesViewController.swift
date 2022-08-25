//
//  CitiesViewController.swift
//  MyWeather
//
//  Created by Никита Анонимов on 23.08.2022.
//

import UIKit

protocol CitiesViewControllerDelegate: AnyObject {
    func reloadTableView()
}

class CitiesViewController: UIViewController {
    
    weak var delegate: CitiesViewControllerDelegate?
    
    let citiesModel: [CitiesModel] = [
        CitiesModel(name: "Kharkiv", lat: "49,9808", lon: "36,2527"),
        CitiesModel(name: "Kyiv", lat: "50.4546600", lon: "30.5238000"),
        CitiesModel(name: "Odessa", lat: "46,48253", lon: "30,72331"),
        CitiesModel(name: "Lviv", lat: "49,8383", lon: "24,0232"),
        CitiesModel(name: "Zaporozhye", lat: "47,8229", lon: "35,1903"),
        CitiesModel(name: "Dnieper", lat: "48.4593", lon: "35.0387"),
        CitiesModel(name: "Vinnitsa", lat: "49.23308", lon: "28.46822"),
        CitiesModel(name: "Ivano-Frankivsk", lat: "48.9215", lon: "24.7097"),
        CitiesModel(name: "Mariupol", lat: "47.0951", lon: "37.5413"),
        CitiesModel(name: "Poltava", lat: "49,5937", lon: "34,5407"),
        CitiesModel(name: "Sumy", lat: "50,9216", lon: "34,8003"),
        CitiesModel(name: "Khmelnitsky", lat: "49.4216100", lon: "26.9965300"),
        CitiesModel(name: "Ternopil", lat: "49.5534", lon: "25.5892"),
        CitiesModel(name: "Kherson", lat: "46.6558", lon: "32.6178"),
        CitiesModel(name: "Mikolaev", lat: "46.9659", lon: "31.9974")
    ]
    
    @IBOutlet var citiesTableView: UITableView!
    
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
//        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        Network.lon = citiesModel[indexPath.row].lon
        Network.lat = citiesModel[indexPath.row].lat
        delegate?.reloadTableView()
        self.dismiss(animated: true)
    }
}
