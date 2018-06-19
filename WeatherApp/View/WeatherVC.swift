//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Ramin Ikhilov  on 6/15/18.
//  Copyright © 2018 Ramin Ikhilov. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{


    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLbl: UILabel!
    
    @IBOutlet weak var weatherTV: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTV.dataSource = self
        weatherTV.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locAuthStatus()
        print(current_weather_url)
        print(forecast_url)
        currentWeather = CurrentWeather()
        currentWeather.downloadCurrentWeatherDetails {
            self.updateUICurrentWeather()
        }
        
        downloadForecastDetails {
            //
        }
    }
    
    
    func locAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitiude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            let lat = Location.sharedInstance.latitiude
            let long = Location.sharedInstance.longitude
            
            print(lat!, long!)
            
        }else{
            locationManager.requestWhenInUseAuthorization()
            //call function again to make sure you obtain current location
            self.view.reloadInputViews()
            locAuthStatus()
        }
    }
        

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let weatherCell = weatherTV.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTVC{
            let forecast = forecasts[indexPath.row]
            weatherCell.configCell(forecast: forecast)
            return weatherCell
        }else{
            return WeatherTVC()
        }
        
    }
    
    func updateUICurrentWeather(){
        let weatherType = currentWeather._weatherType!
        let date = currentWeather.date
        let temp = "\(currentWeather.currentTemp)°"
        let location = currentWeather.cityName
        
        dateLbl.text = date
        currentTempLbl.text = temp
        currentWeatherTypeLbl.text = weatherType
        locationLbl.text = location
        currentWeatherImage.image = UIImage(named: weatherType)
    }
    
    func downloadForecastDetails(completed: @escaping DownloadComplete ){
        let forecastURL = URL(string: forecast_url)!
        Alamofire.request(forecastURL).responseJSON{ response in
            
            let result = response.result
            print(result)
            
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(dict: obj)
                        self.forecasts.append(forecast)
                        //print(obj)
                    }
                    self.weatherTV.reloadData()
                }
            }
            
            completed()
        }
    }
}


