//
//  Coordinate.swift
//  WeatherApp
//
//  Created by Mert Gaygusuz on 12.07.2022.
//

import Foundation

struct Coordinate {
    let latitude : Double
    let longitude : Double
}

extension Coordinate : CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)"
    }
    
    static var alcatrazIsland : Coordinate {
        return Coordinate(latitude: 37.8267, longitude: -122.4233)
    }
}
