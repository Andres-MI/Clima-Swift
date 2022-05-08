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
        //1. Create an URL
        if let url = URL(string: urlString){
            //2. Create a URLSession
            
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            
            //4. Start the task
            task.resume()
        }
        
        
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil{
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data:safeData, encoding: .utf8)
            print(dataString)
        }
    }
    
}

