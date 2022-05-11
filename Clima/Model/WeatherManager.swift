//
//  WeatherManager.swift
//  Clima
//
//  Created by Andrés Melenchón on 21/3/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d2c47fb90279384a63e52adfe52136e4&units=metric&lang=sp"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            //let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(weatherData: safeData){
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temperature)
            return weather
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
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
