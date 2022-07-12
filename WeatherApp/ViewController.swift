//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mert Gaygusuz on 12.07.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var lblTemperatureValue: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPrecipitation: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var btnRefresh: UIButton!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    var locationManager = CLLocationManager()
    
    let client = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        //When the application is opened, it will ask the user for the location information.
        self.locationManager.requestWhenInUseAuthorization()
        
        //Is location service turned on on the device?
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            //starts to receive location information
            locationManager.startUpdatingLocation()
        }
    }
    
    //this block will work when location information changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locationValue : CLLocationCoordinate2D = manager.location!.coordinate
        let clientCoordinate = Coordinate(latitude: locationValue.latitude, longitude: locationValue.longitude)
        updateWeather(coordinate: clientCoordinate)
    }
    
    func updateWeather(coordinate : Coordinate) {
        client.getCurrentWeather(at: coordinate) { currentWeather, error in
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherModel(data: currentWeather)
                
                DispatchQueue.main.sync {
                    self.showWeather(model: viewModel)
                }
            }
        }
    }
    
    func showWeather(model : CurrentWeatherModel) {
        lblSummary.text = model.summary
        lblTemperatureValue.text = model.temperature
        lblHumidity.text = model.humidity
        lblPrecipitation.text = model.precipitationProbability
        weatherIcon.image = model.icon
        indicator.stopAnimating()
    }

    @IBAction func btnRefreshClicked(_ sender: UIButton) {
        indicator.startAnimating()
        locationManager(locationManager, didUpdateLocations: [])
    }

}

