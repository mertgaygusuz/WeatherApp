//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Mert Gaygusuz on 12.07.2022.
//

import Foundation
import UIKit


struct CurrentWeatherModel {
    let summary : String
    let icon : UIImage
    let temperature : String
    let humidity : String
    let precipitationProbability : String
    
    init(data : CurrentWeather){
        self.summary = data.summary
        self.icon = data.iconImage
        self.temperature = "\(Int(data.temperature))°"
        self.humidity = "%\(Int(data.humidity*100))"
        self.precipitationProbability = "%\(data.precipProbability*100)"
    }
}
