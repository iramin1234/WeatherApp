//
//  Forecast.swift
//  WeatherApp
//
//  Created by Ramin Ikhilov  on 6/18/18.
//  Copyright © 2018 Ramin Ikhilov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Forecast{
    var _date: String!
    var _weatherType: String!
    var _highTemp: Double!
    var _lowTemp: Double!
    
    var date: String{
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: Double{
        if _highTemp == nil{
            _highTemp = 0
        }
        return _highTemp
    }
    var lowTemp: Double{
        if _lowTemp == nil{
            _lowTemp = 0
        }
        return _lowTemp
    }
    
    init(dict: Dictionary<String, AnyObject>){
        if let main = dict["main"] as? Dictionary<String, AnyObject>{
            if let min = main["temp_min"] as? Double{
                var calcKtoF = (min - 273) * (9/5) + 32
                calcKtoF = round(calcKtoF)
                self._lowTemp = calcKtoF
                //print("min\(calcKtoF)")
            }
            if let max = main["temp_max"] as? Double{
                var calcKtoF = (max - 273) * (9/5) + 32
                calcKtoF = round(calcKtoF)
                self._highTemp = calcKtoF
                //print("max\(calcKtoF)")
            }
        }
        
        if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
                _weatherType = main
            }
        }
        /*
        if let date = dict["dt_txt"] as? String{
            _date = date
        }
 */
        if let date = dict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "EEEE, h:mm a"
            dateFormatter.timeStyle = .short
            self._date = unixConvertedDate.format()
        }
    }
    
}

extension Date{
    func format() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, h:mm a"
        return dateFormatter.string(from: self)
        
    }
}
