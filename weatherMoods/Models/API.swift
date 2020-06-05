//
//  API.swift
//  weatherMoods
//
//  Created by Anika Morris on 6/4/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

class Api {
    
    func getData(completion: @escaping (WeatherData) -> ()) {
        let session = URLSession.shared
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=San%20Francisco&units=imperial&appid=5956f6201c4fa8d82540e16c891313bb") else { return }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error: \(error)")
            } else {
                
                guard let data = data else { return }
                let dataString = String(data: data, encoding: String.Encoding.utf8)
                print(dataString!)
                guard let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary else {
                    print("Did not recieve data")
                    return
                }
                guard let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary else {
                    print("could not find main dict")
                    return
                }
                guard let temp = mainDictionary.value(forKey: "temp") as? Double else {
                    print("could not find temp")
                    return
                }
                guard let min = mainDictionary.value(forKey: "temp_min") as? Double else {
                    print("could not find min")
                    return
                }
                guard let max = mainDictionary.value(forKey: "temp_max") as? Double else {
                    print("could not find max")
                    return
                }
                guard let weatherArray = jsonObj.value(forKeyPath: "weather") as? NSArray else {
                    print("could not find weather array")
                    return
                }
                guard let weatherDict = weatherArray[0] as? NSDictionary else {
                    print("could not find weather dict")
                    return
                }
                guard let icon = weatherDict.value(forKey: "icon") as? String else {
                    print("could not find icon")
                    return
                }

                let weather = WeatherData(icon: icon, temp: String(Int(temp)), min: String(Int(min)), max: String(Int(max)))
                DispatchQueue.main.async {
                    completion(weather)
                }
            }
        }
        dataTask.resume()
    }
}
