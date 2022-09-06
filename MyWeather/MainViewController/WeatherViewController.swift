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
    private var listModel = [ListModel]() {
        didSet {
            weatherArrayIDs = listModel.filter { list in
                list.dt_txt.contains("15:00:00")
            }.map { _ in
                UUID()
            }
        }
    }
    
    private let todayID = UUID()
    private let hourlyID = UUID()
    private var weatherArrayIDs = [UUID]()
    private var dataSource: UITableViewDiffableDataSource<Int, UUID>!
    
    private var weatherArray: [(high: ListModel, low: ListModel)] {
        let high = listModel.filter { list in
            list.dt_txt.contains("15:00:00")
        }
        
        let low = listModel.filter { list in
            list.dt_txt.contains("21:00:00")
        }
        
        return Array(zip(high, low))
    }
 
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
        
        createDataSource()
        dataSource.defaultRowAnimation = .top
        updateDataSource(animated: false)
        
        update(latitude: 49.4216100, longitude: 26.9965300)
    }
    
    private func createDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: weatherTableView) { [weak self] tableView, indexPath, itemIdentifier in
            guard let self = self else { return UITableViewCell() }
            
            if itemIdentifier == self.todayID {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherTableViewCell", for: indexPath) as! TodayWeatherTableViewCell
                if let todayWeatherModel = self.todayWeatherModel {
                    cell.configureTodayWeather(model: todayWeatherModel)
                }
                cell.delegate = self
                return cell
            } else if itemIdentifier == self.hourlyID {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyWeatherTableViewCell", for: indexPath) as! HourlyWeatherTableViewCell
                if let list = self.hourlyWeatherModel?.list {
                    cell.configureHourlyWeather(with: list)
                }
                return cell
            } else if let index = self.weatherArrayIDs.firstIndex(of: itemIdentifier) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ForFiveDaysWeatherTableViewCell", for: indexPath) as! ForFiveDaysWeatherTableViewCell
                let model = self.weatherArray[index]
                cell.configureWeatherForFiveDays(modelHightTemp: model.high, modelLowTemp: model.low)
                return cell
            }
            
            return UITableViewCell()
        }
    }
    
    private func updateDataSource(animated: Bool = true) {
        var snapshot = dataSource.snapshot()
        if snapshot.sectionIdentifiers.isEmpty {
            snapshot.appendSections([0])
            snapshot.appendItems([todayID, hourlyID])
            snapshot.appendSections([1])
            snapshot.appendItems(weatherArrayIDs, toSection: 1)
        } else {
            snapshot.reconfigureItems([todayID, hourlyID])
            snapshot.deleteSections([1])
            snapshot.appendSections([1])
            snapshot.appendItems(weatherArrayIDs, toSection: 1)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animated)
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
                self?.updateDataSource()
                
            case .failure(let error):
                print(error)
            }
        }
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
