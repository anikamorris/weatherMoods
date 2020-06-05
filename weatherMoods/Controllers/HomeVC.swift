//
//  Home.swift
//  weatherMoods
//
//  Created by Anika Morris on 6/4/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var baseView: UIView!
    @IBOutlet var weatherView: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var moodView: UIView!
    @IBOutlet weak var moodText: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var icon: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.backgroundColor = #colorLiteral(red: 0.9609126449, green: 0.9609126449, blue: 0.9609126449, alpha: 1)
        setupWeatherView()
        let api = Api()
        api.getData() { weather in
            self.icon = self.downloadImage(url: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")
            if let icon = self.icon {
                self.iconImageView.image = icon
            }
            self.tempLabel.text = "Current: \(weather.temp)°"
            self.tempMinLabel.text = "Low: \(weather.min)°"
            self.tempMaxLabel.text = "High: \(weather.max)°"
        }
        setupMoodView()

    }
    
    func downloadImage(url: String) -> UIImage? {
        let url = URL(string: url)
        let data = NSData(contentsOf: url!)
        let image = UIImage(data: data! as Data)
        return image
    }
    
    func setupWeatherView() {
        weatherView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        weatherView.clipsToBounds = true
        weatherView.layer.cornerRadius = 10
        
        tempLabel.textColor = .white
        tempMinLabel.textColor = .white
        tempMaxLabel.textColor = .white
    }
    
    func setupMoodView() {
        moodView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        moodView.clipsToBounds = true
        moodView.layer.cornerRadius = 10
        
        moodText.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        moodText.clipsToBounds = true
        moodText.layer.cornerRadius = 7
        moodText.layer.borderWidth = 2
        moodText.layer.borderColor = #colorLiteral(red: 1, green: 0.431372549, blue: 0.3019607843, alpha: 1)
        
        saveButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
    }
}
