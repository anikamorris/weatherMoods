//
//  API.swift
//  weatherMoods
//
//  Created by Anika Morris on 6/4/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

struct WeatherData {
    let description: String
    let temp: String
    let min: String
    let max: String
}

class Api {
    
    func getData(completion: @escaping (WeatherData) -> ()) {
        let session = URLSession.shared
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=San%20Francisco&units=imperial&appid=5956f6201c4fa8d82540e16c891313bb") else { return }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error: \(error)")
            } else {
                guard let data = data else {
                    print("no data")
                    return
                }
                let dataString = String(data: data, encoding: String.Encoding.utf8)
                print(dataString!)
                guard let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary else {
                    print("Did not recieve data")
                    return
                }
                guard let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary else { return }
                guard let temp = mainDictionary.value(forKey: "temp") as? Double else {
                    print("no temp")
                    return
                }
                guard let min = mainDictionary.value(forKey: "temp_min") as? Int else { return }
                guard let max = mainDictionary.value(forKey: "temp_max") as? Double else { return }
//                guard let weatherDictionary = jsonObj.value(forKey: "weather") as? NSDictionary else { return }
//                guard let description = weatherDictionary.value(forKey: "description") as? String else { return }
                let weather = WeatherData(description: "clouds", temp: String(temp), min: String(min), max: String(max))
                DispatchQueue.main.async {
                    completion(weather)
                }
            }
        }
        dataTask.resume()
    }
}

//                if let data = data {
//                    let dataString = String(data: data, encoding: String.Encoding.utf8)
//                    print("All weather data: \n \(dataString!)")
//                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
//                        if let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary {
//                                if let temperature = mainDictionary.value(forKey: "temp") {
//                                    DispatchQueue.main.async {
//                                        print(temperature)
//                                        print(String(describing: type(of: temperature)))
//                                    }
//                                } else {
//                                    print("Unable to find temperature")
//                                }
//
//                        } else {
//                            print("Unable to find main")
//                        }
//                    }
//                } else {
//                    print("Did not recieve data")
//                }
//            }
