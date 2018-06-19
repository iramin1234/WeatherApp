//
//  Constants.swift
//  WeatherApp
//
//  Created by Ramin Ikhilov  on 6/17/18.
//  Copyright © 2018 Ramin Ikhilov. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let CURRWEATHER = "weather?"
let FORECAST = "forecast?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "115d088469be65ca7f134b7a3750886a"
let LAT_VALUE = "\(Location.sharedInstance.latitiude!)"
let LONG_VALUE = "\(Location.sharedInstance.longitude!)"


let current_weather_url = "\(BASE_URL)\(CURRWEATHER)\(LATITUDE)" + LAT_VALUE + "\(LONGITUDE)" + LONG_VALUE + "\(APP_ID)\(API_KEY)"
let forecast_url = "\(BASE_URL)\(FORECAST)\(LATITUDE)" + LAT_VALUE + "\(LONGITUDE)" + LONG_VALUE + "\(APP_ID)\(API_KEY)"

typealias DownloadComplete = () -> ()
