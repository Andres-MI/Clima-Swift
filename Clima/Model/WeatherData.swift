//
//  WeatherData.swift
//  Clima
//
//  Created by Andrés Melenchón on 9/5/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    var temp: Double
}

struct Weather: Decodable {
    var description: String
}