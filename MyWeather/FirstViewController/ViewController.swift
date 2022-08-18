//
//  ViewController.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var network = Network()
    var todayWeatherModel = TodayWeatherNetworkModel()
    var weatherForFiveDaysModel = HourlyWeatherNetworkModel()
    var weatherArrayModel = [List]()
    
    var weatherArrayHight: [List] {
        return weatherArrayModel.filter { list in
            list.dt_txt.contains("15:00:00")
        }
    }
    
    var weatherArrayLow: [List] {
        return weatherArrayModel.filter { list in
            list.dt_txt.contains("21:00:00")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.register(
            UINib(nibName: "TodayWeatherTableViewCell", bundle: .main),
            forCellReuseIdentifier: "TodayWeatherTableViewCell"
        )
        
        tableView.register(
            UINib(nibName: "HourlyWeatherTableViewCell", bundle: .main),
            forCellReuseIdentifier: "HourlyWeatherTableViewCell"
        )
        
        tableView.register(
            UINib(nibName: "ForFiveDaysWeatherTableViewCell", bundle: .main),
            forCellReuseIdentifier: "ForFiveDaysWeatherTableViewCell"
        )
        
        
        network.fetchWeather { weather in
            self.todayWeatherModel = weather
//            print(self.todayWeather)
        }

        network.fetchForecast { forecast in
            self.weatherForFiveDaysModel = forecast
            self.weatherArrayModel = forecast.list
//            print(self.weatherForFiveDays)
            self.tableView.reloadData()
//            print(self.weatherArrayHight)
//            print(self.weatherArrayLow)
        }
        
    }
}

extension ViewController: UITableViewDataSource {
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
