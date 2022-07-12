//
//  APIClient.swift
//  WeatherApp
//
//  Created by Mert Gaygusuz on 12.07.2022.
//

import Foundation


class APIClient {
    fileprivate let apiKey = "4cb418bb54aa70da51742e395c441723"
    
    lazy var baseURL : URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.apiKey)/")!
    }()
    
    let downloader = JSONDownloader()
    
    typealias CurrentWeatherTypeCompletionHandler = (CurrentWeather?, APIError?) -> Void
    typealias WeatherCompletionHandler = (Weather?, APIError?) -> Void
    private func getWeather(at coordinate : Coordinate, completionHandler completion : @escaping WeatherCompletionHandler) {
        
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else {
            completion(nil, APIError.invalidURL)
            return
        }
        
        let requestURL = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: requestURL) { json, error in
            guard let json = json else {
                completion(nil, error)
                return
            }
            //we have an existing json
            
            guard let weather = Weather(json: json) else {
                completion(nil, APIError.JSONParsingError)
                return
            }
            
            completion(weather, nil)
        }
        task.resume()
    }
    
    func getCurrentWeather(at coordinate : Coordinate, completionHandler completion : @escaping CurrentWeatherTypeCompletionHandler) {
        getWeather(at: coordinate) {weather, error in
            completion(weather?.currently, error)
        }
    }
}
