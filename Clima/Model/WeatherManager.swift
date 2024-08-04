//
//  WeatherManager.swift
//  Clima
//
//  Created by Zak Ashour on 5/30/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let apiKey = "a9002e70fd10d2f19c5f6e3fd02f33e9"
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func apiKeyExtension() -> String{
        return "?appid=\(apiKey)"
    }
    
    func unitsExtension(_ units: String) -> String{
        return "&units=\(units)"
    }
    
    func cityExtension(_ cityName: String) -> String {
        return "&q=\(cityName)"
    }
    
    func fetchWeather(cityName: String, units: String = "metric" ){
        let weatherURL: String = baseURL+apiKeyExtension()+unitsExtension(units)+cityExtension(cityName)
        print(weatherURL)
        performRequest(urlString: weatherURL)
    }
    
    func performRequest(urlString: String){
        //Create URL
        if let url = URL(string: urlString){
            ///Create URLSession
            let session = URLSession(configuration: .default)
            //Give Session a task
            let task = session.dataTask(with: url, completionHandler: { (data, response,error) in
                if(error != nil){
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let dataString = String(data: safeData, encoding: .utf8){
                        print(dataString)
                        self.parseJSON(data: Data)
                    }else{
                        print("NULL RESPONSE ")
                    }
                    
                }
            })
            //Start task
            task.resume()
        }
    }
    
    func parseJSON(data: Data){
        
    }
    
    
}
