//
//  weatherManager.swift
//  Clima
//
//  Created by 최진용 on 2022/08/26.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager, weather: WeatherModel)
    func didFailWithError(error : Error)
}


struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=21c41e4a5832836a9f243ba0123c6f02&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchUrl(cityName: String){
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performUrl(with: urlString)
    }
    
    func fetchUrl(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        performUrl(with: urlString)
    }
    
    func performUrl(with urlString: String){
        if let url = URL(string: urlString ){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safedata = data{
                    if let weather =  self.parseJSON(safedata){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let cityName = decodedData.name
            
            let weather = WeatherModel(conditionId: id, temp: temperature, cityName: cityName)
            return weather
            
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
