//
//  APIError.swift
//  WeatherApp
//
//  Created by Mert Gaygusuz on 12.07.2022.
//

import Foundation

enum APIError {
    case RequestError
    case ResponseUnsuccesful(statusCode: Int)
    case invalidData
    case JSONParsingError
    case invalidURL
}
