//
//  weatherData.swift
//  Clima
//
//  Created by 최진용 on 2022/08/28.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

struct WeatherData: Decodable{
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main: Decodable{
    let temp: Double
    
}

struct Weather : Decodable{
    let id : Int
}
