//
//  ViewController.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    @IBOutlet var weatherTableView: UITableView!
    
    var network = Network()
    var todayWeatherModel = TodayWeatherNetworkModel()
    var hourlyWeatherModel = HourlyWeatherNetworkModel()
    var listModel = [ListModel]()
    var weatherModel = [WeatherModel]()
    var citiesVC = CitiesViewController()
    
    var weatherArrayHight: [ListModel] {
        return listModel.filter { list in
            list.dt_txt.contains("15:00:00")
        }
    }
    
    var weatherArrayLow: [ListModel] {
        return listModel.filter { list in
            list.dt_txt.contains("21:00:00")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        citiesVC.delegate = self
        
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
        
        
        network.fetchWeather { [weak self] weather in
            self?.todayWeatherModel = weather
//            print(self.todayWeather)
        }

        network.fetchForecast { [weak self] forecast in
            self?.hourlyWeatherModel = forecast
            self?.listModel = forecast.list
//            print(self.weatherForFiveDays)
            self?.weatherTableView.reloadData()
//            print(self.weatherArrayHight)
//            print(self.weatherArrayLow)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.weatherTableView.reloadData()
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherArrayHight.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellFirst = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherTableViewCell", for: indexPath) as! TodayWeatherTableViewCell
            cellFirst.configureTodayWeather(model: todayWeatherModel)
            return cellFirst
        }
        
        if indexPath.row == 1 {
            let cellSecond = tableView.dequeueReusableCell(withIdentifier: "HourlyWeatherTableViewCell", for: indexPath) as! HourlyWeatherTableViewCell
            return cellSecond
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForFiveDaysWeatherTableViewCell", for: indexPath) as! ForFiveDaysWeatherTableViewCell
//        cell.configureWeatherForFiveDays(model: weatherArrayHight[indexPath.row - 2])
        cell.configureWeatherForFiveDays(modelHightTemp: weatherArrayHight[indexPath.row - 2], modelLowTemp: weatherArrayLow[indexPath.row - 2])
        return cell
    }
}

extension WeatherViewController: CitiesViewControllerDelegate {
    func reloadTableView() {
        network.fetchWeather { [weak self] weather in
            self?.todayWeatherModel = weather
//            print(self.todayWeather)
        }

        network.fetchForecast { [weak self] forecast in
            self?.hourlyWeatherModel = forecast
            self?.listModel = forecast.list
//            print(self.weatherForFiveDays)
            self?.weatherTableView.reloadData()
//            print(self.weatherArrayHight)
//            print(self.weatherArrayLow)
        }
    }
}
