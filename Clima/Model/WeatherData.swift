//
//  WeatherData.swift
//  Clima
//
//  Created by Zak Ashour on 5/30/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable{
    let coord: Coord
    let weather: Array<WeatherInstance>
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds:Clouds
    let dt: CLong
    let sys: System
    let timezone: Int
    let id: Int
    let name: String
    let  cod: Int
}

struct System: Decodable{
    let type: Int?
    let id: CLong?
    let country: String
    let sunrise: CLong
    let sunset: CLong
}

struct Clouds: Decodable{
    let all: Int
}

struct Wind: Decodable{
    let speed: Float
    let deg: Int
}

struct Main: Codable{
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let humidity: Int
}

struct WeatherInstance: Codable{
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Coord: Codable{
    let lon: Double
    let lat: Double
}
