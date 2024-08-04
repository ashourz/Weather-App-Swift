//
//  WeatherManager.swift
//  Clima
//
//  Created by Zak Ashour on 5/30/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    var delegate: WeatherManagerDelegate?
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
    
    func coordExtension(_ lat: Double, _ lon: Double) -> String {
        return "&lat=\(lat)&lon=\(lon)"
    }
    
    func fetchWeather(cityName: String, units: String = "metric" ){
        let weatherURL: String = baseURL+apiKeyExtension()+unitsExtension(units)+cityExtension(cityName)
        print(weatherURL)
        performRequest(with: weatherURL)
    }
    
    func fetchWeather(lat: Double, lon:Double, units: String = "metric" ){
        let weatherURL: String = baseURL+apiKeyExtension()+unitsExtension(units)+coordExtension(lat, lon)
        print(weatherURL)
        performRequest(with: weatherURL)
    }
    
    func performRequest(with urlString: String){
        //Create URL
        if let url = URL(string: urlString){
            ///Create URLSession
            let session = URLSession(configuration: .default)
            //Give Session a task
            let task = session.dataTask(with: url, completionHandler: { (data, response,error) in
                if(error != nil){
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let dataString = String(data: safeData, encoding: .utf8){
                        print(dataString)
                        if let weather = self.parseJSON(safeData){
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }else{
                        print("NULL RESPONSE ")
                    }
                    
                }
            })
            //Start task
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            print(weather.temperatureString)
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)

        }
        return nil
    }
    
}
