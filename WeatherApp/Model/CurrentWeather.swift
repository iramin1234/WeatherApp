//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Ramin Ikhilov  on 6/17/18.
//  Copyright © 2018 Ramin Ikhilov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CurrentWeather{
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String{
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    var date: String{
        if _date == nil{
            _date = ""
        }
        //formate the date to a specific style using DateFormatter
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double{
        if _currentTemp == nil{
            _currentTemp = 0
        }
        return _currentTemp
    }
    
    func downloadCurrentWeatherDetails(completed: @escaping DownloadComplete){
        
        let currentWeatherURL = URL(string: current_weather_url)!
        Alamofire.request(currentWeatherURL).responseJSON{ response in
            
            let result = response.result
            print(result)
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                    //print(self._cityName)
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    if let temp = main["temp"] as? Double{
                        
                        //Kelvin to Fahrenheit    ° F = 9/5 (K - 273) + 32
                        var calcKtoF = (temp - 273) * (9/5) + 32
                        calcKtoF = round(calcKtoF)
                        self._currentTemp = calcKtoF
                        //print(self._currentTemp)
                    }
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main
                        //print(self._weatherType)
                    }
                }
            }
            
            completed()
        }
        
        
    }
}


