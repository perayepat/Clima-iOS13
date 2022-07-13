//
//  WeatherData.swift
//  Clima
//
//  Created by IACD-013 on 2022/07/13.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Codable, Identifiable {
    var id: Int
    var name: String
    var main: Main
    var weather: [Weather]
    var wind: Wind
}

struct Main: Codable {
    var temp: Double
    var pressure: Int
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
}

struct Weather: Codable{
    var id: Int
    var description: String
}

struct Wind: Codable{
    var speed: Double
    var deg: Int
}


