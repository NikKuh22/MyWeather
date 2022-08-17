//
//  Network.swift
//  MyWeather
//
//  Created by Никита Анонимов on 16.08.2022.
//

import UIKit

final class Network {
    
    static private let hourlyWeatherAPI = "https://api.openweathermap.org/data/2.5/forecast?lat=49.9808100&lon=36.2527200&appid=ab9e156b0d72b67b72bcf69beeef701b&units=metric"
    
    static private let todayWeatherAPI = "https://api.openweathermap.org/data/2.5/weather?lat=49.9808100&lon=36.2527200&appid=ab9e156b0d72b67b72bcf69beeef701b&units=metric"
    
    func fetchWeather(completion: @escaping (TodayWeatherNetworkModel) -> Void) {
        guard let todayWeatherURL = URL(string: Network.todayWeatherAPI) else { return }
        
        fetchTodayWeather(from: todayWeatherURL, completion: completion)
    }
    
    func fetchForecast(completion: @escaping (HourlyWeatherNetworkModel) -> Void) {
        guard let hourlyWeatherURL = URL(string: Network.hourlyWeatherAPI) else { return }
        
        fetchHourlyWeather(from: hourlyWeatherURL, completion: completion)
    }
    
    private func fetchTodayWeather(from url: URL, completion: @escaping (TodayWeatherNetworkModel) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }

            do {
                let task = try JSONDecoder().decode(TodayWeatherNetworkModel.self, from: data)
                DispatchQueue.main.async {
                    completion(task)
                }
            } catch {
                print(error)
            }

        }.resume()
    }
    
    private func fetchHourlyWeather(from url: URL, completion: @escaping (HourlyWeatherNetworkModel) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }

            do {
                let task = try JSONDecoder().decode(HourlyWeatherNetworkModel.self, from: data)
                DispatchQueue.main.async {
                    completion(task)
                }
            } catch {
                print(error)
            }

        }.resume()
    }
}
