//
//  MoodCell.swift
//  weatherMoods
//
//  Created by Anika Morris on 6/4/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import UIKit

class MoodCell: UITableViewCell {

    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
