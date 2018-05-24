//
//  Weather.swift
//  NetworkingDemo
//
//  Created by Mohamed Sobhi  Fouda on 5/24/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import Foundation

class Weather {
    
    var id: Int
    var cityName: String
    var temperature: Double
    var weatherDescription: String
    
    init(id: Int, cityName: String, temperature: Double, weatherDescription: String) {
        self.id = id
        self.cityName = cityName
        self.temperature = temperature
        self.weatherDescription = weatherDescription
    }
    
}
