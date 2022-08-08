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

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModel)
    func didFailWithError(error:Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=45cb5cee5e89dd15f66a9938da7b912e&units=metric"
    
    var delegate: WeatherManagerDelegate? 
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        peformRequest(with:urlString)
    }
    
    func fetchWeather(latitude: Double, longitude: Double){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        peformRequest(with: urlString)
    }
    
    func peformRequest(with urlString: String){
        guard let url = URL(string: urlString) else { return }
        let session  = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data{
                    //Decode Json
                guard let weather = parseJSON(safeData) else { return }
                delegate?.didUpdateWeather(self, weather)
            }
        }
        task.resume()
     
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            //Change Weather Icon
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather  = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

}

