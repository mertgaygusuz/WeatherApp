//
//  JSONDownloader.swift
//  WeatherApp
//
//  Created by Mert Gaygusuz on 12.07.2022.
//

import Foundation

class JSONDownloader {
    let session : URLSession
    
    init(config : URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }
    
    convenience init() {
        self.init(config : URLSessionConfiguration.default)
    }
    
    typealias JSON = [String : AnyObject]
    typealias JSONDownloaderCompletionHandler = (JSON? , APIError?) -> Void
    func jsonTask(with request : URLRequest, completionHandler completion : @escaping JSONDownloaderCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) {data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, APIError.RequestError)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(json, nil)
                    } catch {
                        completion(nil, APIError.JSONParsingError)
                    }
                }
                else {
                    completion(nil, APIError.invalidData)
                }
            }
            else {
                //An error occurred
                completion(nil, APIError.ResponseUnsuccesful(statusCode: httpResponse.statusCode))
            }
        }
        return task
    }
}
