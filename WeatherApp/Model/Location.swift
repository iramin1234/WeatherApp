//
//  Location.swift
//  WeatherApp
//
//  Created by Ramin Ikhilov  on 6/18/18.
//  Copyright © 2018 Ramin Ikhilov. All rights reserved.
//

import Foundation
import CoreLocation

class Location{
    static var sharedInstance = Location()
    private init(){}
    
    var latitiude: Double!
    var longitude: Double!
}
