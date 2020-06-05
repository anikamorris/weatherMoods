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
    var iconName: String?
    var buttonState: Int = 0
    var moodInputtedToday: Bool = false
    let persistence = PersistenceLayer()
    
    let sameDay: (Int?, Int) -> Bool = { day1, day2 in
        return day1 == day2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let day = Day()
        if let persistDay = persistence.day {
            moodInputtedToday = sameDay(persistDay.getDay(), day.getDay())
        }
        
        baseView.backgroundColor = #colorLiteral(red: 0.9609126449, green: 0.9609126449, blue: 0.9609126449, alpha: 1)
        setupWeatherView()
        let api = Api()
        api.getData() { weather in
            self.tempLabel.textColor = .white
            self.tempLabel.text = "Current: \(weather.temp)°"
            self.tempMinLabel.text = "Low: \(weather.min)°"
            self.tempMaxLabel.text = "High: \(weather.max)°"
            self.iconName = weather.icon
            
            guard let url = URL(string: "https://openweathermap.org/img/wn/\(self.iconName!)@2x.png") else { return }
            self.iconImageView.downloaded(from: url)
        }
        setupMoodView()
    }
    
    func setupWeatherView() {
        weatherView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        weatherView.clipsToBounds = true
        weatherView.layer.cornerRadius = 10
        
        tempLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tempMinLabel.textColor = .white
        tempMaxLabel.textColor = .white
    }
    
    func moodTextEditState() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(#colorLiteral(red: 1, green: 0.431372549, blue: 0.3019607843, alpha: 1), for: .normal)
        moodText.isEditable = true
        moodText.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        moodText.textColor = .darkText
    }
    
    func moodTextSaveState() {
        saveButton.setTitle("Edit", for: .normal)
        saveButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        moodText.isEditable = false
        moodText.backgroundColor = #colorLiteral(red: 1, green: 0.431372549, blue: 0.3019607843, alpha: 1)
        moodText.textColor = .white
    }
    
    func setupMoodView() {
        moodView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        moodView.clipsToBounds = true
        moodView.layer.cornerRadius = 10
        moodText.clipsToBounds = true
        moodText.layer.cornerRadius = 7
        moodText.layer.borderWidth = 4
        moodText.layer.borderColor = #colorLiteral(red: 1, green: 0.431372549, blue: 0.3019607843, alpha: 1)
        moodText.contentInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        print(moodInputtedToday)
        
        if moodInputtedToday {
            buttonState = 0
            moodText.text = persistence.moodJournal[0].mood.mood
            moodTextSaveState()
        } else {
            moodTextEditState()
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        var persistence = PersistenceLayer()
        guard let mood = moodText.text else { return }
        
        // edit
        if buttonState > 0 {
            buttonState -= 1
            moodTextEditState()
        // save
        } else {
            buttonState += 1
            if moodInputtedToday {
                // updating today's mood
                persistence.updateMoodHistory(0, newMood: mood)
                persistence.setNeedsToReloadMoodJournal()
            } else {
                // first time today
                moodInputtedToday = true
                persistence.newMoodHistory(mood: mood, day: persistence.day!, icon: iconName!)
            }
            moodTextSaveState()
        }
    }
    
    func makeFiveNewMoods(_ persist: PersistenceLayer) {
        
    }
}
