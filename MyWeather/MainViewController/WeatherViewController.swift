//
//  ViewController.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    @IBOutlet private var weatherTableView: UITableView!
    
    private var network = Network()
    private var todayWeatherModel: TodayWeatherNetworkModel?
    private var hourlyWeatherModel: HourlyWeatherNetworkModel?
    private var listModel = [ListModel]()
    
    private var weatherArrayHigh: [ListModel] {
        return listModel.filter { list in
            list.dt_txt.contains("15:00:00")
        }
    }
    
    private var weatherArrayLow: [ListModel] {
        return listModel.filter { list in
            list.dt_txt.contains("21:00:00")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.dataSource = self
        
        weatherTableView.register(
            UINib(nibName: "TodayWeatherTableViewCell", bundle: .main),
            forCellReuseIdentifier: "TodayWeatherTableViewCell"
        )
        
        weatherTableView.register(
            UINib(nibName: "HourlyWeatherTableViewCell", bundle: .main),
            forCellReuseIdentifier: "HourlyWeatherTableViewCell"
        )
        
        weatherTableView.register(
            UINib(nibName: "ForFiveDaysWeatherTableViewCell", bundle: .main),
            forCellReuseIdentifier: "ForFiveDaysWeatherTableViewCell"
        )
        
        update(latitude: 49.4216100, longitude: 26.9965300)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.weatherTableView.reloadData()
    }
    
    private func update(latitude: Double, longitude: Double) {
        network.fetchWeather(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.todayWeatherModel = weather
                
            case .failure(let error):
                print(error)
            }
        }
        
        network.fetchForecast(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let forecast):
                self?.hourlyWeatherModel = forecast
                self?.listModel = forecast.list
                self?.weatherTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherArrayHigh.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellFirst = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherTableViewCell", for: indexPath) as! TodayWeatherTableViewCell
            if let todayWeatherModel = todayWeatherModel {
                cellFirst.configureTodayWeather(model: todayWeatherModel)
            }
            cellFirst.delegate = self
            return cellFirst
        }
        
        if indexPath.row == 1 {
            let cellSecond = tableView.dequeueReusableCell(withIdentifier: "HourlyWeatherTableViewCell", for: indexPath) as! HourlyWeatherTableViewCell
            if let list = hourlyWeatherModel?.list {
                cellSecond.configure(with: list)
            }
            return cellSecond
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForFiveDaysWeatherTableViewCell", for: indexPath) as! ForFiveDaysWeatherTableViewCell
//        cell.configureWeatherForFiveDays(model: weatherArrayHight[indexPath.row - 2])
        cell.configureWeatherForFiveDays(modelHightTemp: weatherArrayHigh[indexPath.row - 2], modelLowTemp: weatherArrayLow[indexPath.row - 2])
        return cell
    }
}

extension WeatherViewController: CitiesViewControllerDelegate {
    func citiesViewControllerDidSelect(
        _ citiesViewController: CitiesViewController,
        latitude: Double,
        longitude: Double
    ) {
        update(latitude: latitude, longitude: longitude)
    }
}

extension WeatherViewController: TodayWeatherTableViewCellDelegate {
    func presentViewController() {
        let citiesViewController = UIStoryboard(
            name: "Main",
            bundle: .main
        ).instantiateViewController(withIdentifier: "CitiesViewController") as! CitiesViewController
        
        citiesViewController.delegate = self
        
        present(citiesViewController, animated: true)
    }
}
