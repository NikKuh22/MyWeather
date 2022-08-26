//
//  Network.swift
//  MyWeather
//
//  Created by Никита Анонимов on 16.08.2022.
//

import Foundation

final class Network {
    private static let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/")!
    private static let forecastURL = baseURL.appendingPathComponent("forecast")
    private static let weatherURL = baseURL.appendingPathComponent("weather")
    
    func fetchWeather(
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<TodayWeatherNetworkModel, Error>) -> Void
    ) {
        fetch(
            from: Self.weatherURL,
            latitude: latitude,
            longitude: longitude,
            completion: completion
        )
    }
    
    func fetchForecast(
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<HourlyWeatherNetworkModel, Error>) -> Void
    ) {
        fetch(
            from: Self.forecastURL,
            latitude: latitude,
            longitude: longitude,
            completion: completion
        )
    }
}

extension Network {
    enum Errors: Error {
        case badURL
    }
}

// MARK: - Private
private extension Network {
    func fetch<Model: Decodable>(
        from baseURL: URL,
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<Model, Error>) -> Void
    ) {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            completion(.failure(Errors.badURL))
            return
        }
        
        components.queryItems = generateQuery(latitude: latitude, longitude: longitude)
        
        guard let url = components.url else {
            completion(.failure(Errors.badURL))
            return
        }
        
        fetch(from: url, completion: completion)
    }
    
    func fetch<Model: Decodable>(
        from url: URL,
        completion: @escaping (Result<Model, Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }

            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func generateQuery(latitude: Double, longitude: Double) -> [URLQueryItem] {
        [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "appid", value: "ab9e156b0d72b67b72bcf69beeef701b"),
            URLQueryItem(name: "units", value: "metric")
        ]
    }
}
