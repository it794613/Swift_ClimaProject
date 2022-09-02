//
//  weatherModel.swift
//  Clima
//
//  Created by 최진용 on 2022/08/30.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
struct WeatherModel{
    let conditionId: Int
    let temp : Double
    let cityName : String
    var tempString : String{
        return String(format: "%.1f", temp)
    }
    
    var conditionName : String{
        switch conditionId{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...621:
            return "cloud.snow"
        case 700...782:
            return "cloud.fog"
        case 800:
            return  "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
