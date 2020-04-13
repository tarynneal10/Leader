//
//  QADetailsVC.swift
//  Leader
//
//  Created by Taryn Neal on 4/5/20.
//  Copyright © 2020 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit

class QADetailsVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    
    var details : [String] = []
    var questionBank = FAQBank()
    var questions : [Question] = []
    var passedValue = ""
    
     override func viewDidLoad() {
         super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 35.0
        tableView.rowHeight = UITableView.automaticDimension
        
        questions = questionBank.questions
        questionLabel.text = passedValue
        for (index, value) in questions.enumerated() {
            if passedValue == value.question {
                details.append(value.answer)
            }
        }
        
         
     }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qaDetailsCell", for: indexPath as IndexPath)as! QADetailsCell
        
        cell.label.text = details[indexPath.row]

        return cell
    }
    
    
}

class QADetailsCell : UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
}
