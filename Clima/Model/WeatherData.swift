//
//  WeatherData.swift
//  Clima
//
//  Created by IACD-013 on 2022/07/13.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Decodable, Identifiable {
    var id: Int
    var name: String
    var main: Main
    var weather: [Weather]
    var wind: Wind
}

struct Main: Decodable {
    var temp: Double
    var pressure: Int
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
}

struct Weather: Decodable{
    var id: Int
    var main: String
    var description: String
}

struct Wind: Decodable{
    var speed: Double
    var deg: Int
}


