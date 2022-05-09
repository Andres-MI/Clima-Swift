//
//  WeatherManager.swift
//  Clima
//
//  Created by Andrés Melenchón on 21/3/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d2c47fb90279384a63e52adfe52136e4&units=metric&lang=sp"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            //let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data:safeData, encoding: .utf8)
                    self.parseJson(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch{
            print (error)
        }
    }
    
    //    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
    //        if error != nil{
    //            print(error!)
    //            return
    //        }
    //        if let safeData = data {
    //            let dataString = String(data:safeData, encoding: .utf8)
    //            print(dataString)
    //        }
    //    }
    
}

