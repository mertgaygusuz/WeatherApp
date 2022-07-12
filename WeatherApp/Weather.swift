//
//  Weather.swift
//  WeatherApp
//
//  Created by Mert Gaygusuz on 12.07.2022.
//

import Foundation

struct Weather {
    let currently : CurrentWeather
}

extension Weather {
    init?(json : [String : AnyObject]) {
        guard let currentWeatherJSON = json["currently"] as? [String : AnyObject],
              let currentWeather = CurrentWeather(json: currentWeatherJSON) else {
            return nil
        }
        self.currently = currentWeather
    }
}
