//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    var weatherForCity : String = ""
    var latestLocation: CLLocation = CLLocation(latitude: 1, longitude: 1)
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        //note: trigger location request
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // set delegate so its not nill
       
        searchTextField.delegate = self
        weatherManager.delegate = self
 
        
        
        
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton)
    {
        locationManager.requestLocation()
//        weatherManager.fetchWeather(latitude:latestLocation.coordinate.latitude , longitude: latestLocation.coordinate.longitude)
    }
}

//MARK: - Text view delegate extension
extension WeatherViewController : UITextFieldDelegate{
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    ///The textfield class is responsible for triggering these methods
    ///With multiple texfields it depends on which text field triggered the method first
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != ""){
            return true
        }else{
            textField.placeholder = "Type a city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //when code is done editing
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        weatherForCity = searchTextField.text ?? ""
        searchTextField.text = ""
    }
}

//MARK: -Weather Manager delegate extension
extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModel) {
        //Set user Interface
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Location Manager Delegate
extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.latestLocation = locations.last!
        locationManager.stopUpdatingLocation()
        weatherManager.fetchWeather(latitude:latestLocation.coordinate.latitude , longitude: latestLocation.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
