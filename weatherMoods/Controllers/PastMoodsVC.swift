//
//  PastMoodsVC.swift
//  weatherMoods
//
//  Created by Anika Morris on 6/4/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

class PastMoodsVC: UITableViewController {
    
    private var persistence = PersistenceLayer()
    
    @IBOutlet weak var moodCardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView() {
        self.tableView.backgroundColor = #colorLiteral(red: 0.9609126449, green: 0.9609126449, blue: 0.9609126449, alpha: 1)
        self.tableView.separatorColor = #colorLiteral(red: 0.9609126449, green: 0.9609126449, blue: 0.9609126449, alpha: 1)
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 30.0)
    }
    
    func setUpCell(_ cell: MoodCell) {
        cell.moodLabel.textColor = .darkText
        
        cell.backgroundColor = #colorLiteral(red: 0.9609126449, green: 0.9609126449, blue: 0.9609126449, alpha: 1)
        cell.cardView.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.431372549, blue: 0.3019607843, alpha: 1)
        cell.cardView.layer.cornerRadius = 5
        cell.cardView.clipsToBounds = true
        cell.cardView.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        cell.cardView.layer.borderWidth = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        persistence.setNeedsToReloadMoodJournal()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistence.moodJournal.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moodCell", for: indexPath) as! MoodCell
        setUpCell(cell)
        
        let moodHistory = persistence.moodJournal[indexPath.row]
        cell.moodLabel.text = moodHistory.mood.mood
        cell.dateLabel.text = moodHistory.date.getDate()
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(moodHistory.icon)@2x.png") else { return cell }
        cell.weatherImageView.downloaded(from: url)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            persistence.deleteMoodHistory(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
