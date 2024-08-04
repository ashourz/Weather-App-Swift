//
//  WeatherModel.swift
//  Clima
//
//  Created by Zak Ashour on 5/30/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionId: Int
    let cityName: String
    let temperature: Float
    
    var conditionName: String {
        return switch(conditionId){
        case 210, 211, 212, 221:
            //Thunderstorm w/o rain
            "cloud.bolt"
        case 200, 201, 202, 230, 231, 232:
            //Thunderstorm w/ rain
            "cloud.bolt.rain"
        case 300...399:
            //Drizzle
            "cloud.drizzle"
        case 500, 501, 511, 520, 521:
            //Rain
            "cloud.rain"
        case 502, 503, 504, 522, 531:
            //Heavy Rain
            "cloud.heavyrain"
        case 600...699:
            //Snow
            "cloud.snow"
        case 700...771:
            //Smoke
            "smoke"
        case 781:
            //Tornado
            "tornado"
        case 800:
            //Clear
            "sun.max"
        case 801...899:
            //Clouds
            "cloud"
        default:
            "rainbow"
        }
    }
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
}
