//
//  ViewController.swift
//  MyWeather
//
//  Created by Никита Анонимов on 15.08.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

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
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellFirst = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherTableViewCell", for: indexPath) as! TodayWeatherTableViewCell
            return cellFirst
        }
        let cellSecond = tableView.dequeueReusableCell(withIdentifier: "HourlyWeatherTableViewCell", for: indexPath) as! HourlyWeatherTableViewCell
        return cellSecond
    }
}
