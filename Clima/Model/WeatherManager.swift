    //
    //  WeatherManager.swift
    //  Clima
    //
    //  Created by IACD-013 on 2022/07/12.
    //  Copyright © 2022 App Brewery. All rights reserved.
    //
    /// 1. passing a call the the method handle and letting the completioin handler be triggered by the task
    ///
import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=45cb5cee5e89dd15f66a9938da7b912e&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        peformRequest(urlString: urlString)
    }
    
    func peformRequest(urlString: String){
        guard let url = URL(string: urlString) else { return }
        let session  = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data{
                    //Decode Json
                parseJSON(weatherData: safeData)
            }
        }
        task.resume()
        
    }
        //    func handle(data: Data?, response: URLResponse?, error: Error?){
        //        if error != nil {
        //            print(error!)
        //            return
        //        }
        //
        //        if let safeData = data{
        //            let dataString = String(data: safeData, encoding: .utf8)
        //
        //        }
        //    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.humidity)
        } catch {
            print(error)
        }
    }
}

