//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class TestController : UIViewController, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

class WeatherViewController: UIViewController{
    
    let testControllerIns = TestController()
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
    @IBAction func LocationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}




//MARK: CLLManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManager.fetchUrl(latitude: lat, longitude: long)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


//MARK: UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""{
            return true
        }else {
            searchTextField.placeholder = "Type any city"
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""{
            print(searchTextField.text!)
        }else{
            searchTextField.placeholder = "type the city "
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchUrl(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        print(weather.temp)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
