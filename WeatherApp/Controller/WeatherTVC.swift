//
//  WeatherTVC.swift
//  WeatherApp
//
//  Created by Mark Ikhilov  on 6/18/18.
//  Copyright © 2018 Ramin Ikhilov. All rights reserved.
//

import UIKit

class WeatherTVC: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(forecast: Forecast){
        weatherIcon.image = UIImage(named: forecast._weatherType)
        dateLbl.text = forecast._date
        weatherTypeLbl.text = forecast.weatherType
        
        let hightemp = String(forecast._highTemp) + "°"
        let lowtemp = String(forecast._lowTemp) + "°"
        
        highTempLbl.text = hightemp
        lowTempLbl.text = lowtemp
        
    }


}
