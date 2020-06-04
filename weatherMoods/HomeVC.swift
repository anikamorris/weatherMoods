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
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let api = Api()
        api.getData() { weather in
            self.descriptionLabel.text = weather.description
            self.tempLabel.text = weather.temp
            self.tempMinLabel.text = weather.min
            self.tempMaxLabel.text = weather.max
        }
    }

}
