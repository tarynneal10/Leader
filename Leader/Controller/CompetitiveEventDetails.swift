//
//  CompetitiveEventDetails.swift
//  Leader
//
//  Created by Taryn Neal on 8/23/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class CompetitiveEventDetailsVC : UIViewController {
    let realm = try! Realm()
    var competitiveEvents : Results<CompetitiveEvents>?
    var eventName : String?
    var selectedEvent : CompetitiveEvents? {
        didSet{
            loadDetails()
        }
    }
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // loadCompetitiveEvents()
        nameLabel.text = eventName
        
        
    }
    func loadDetails() {
       // eventName = selectedEvent?.name
        //.sorted(byKeyPath: "title", ascending: true)
        
       // tableView.reloadData()
    }
//    func selectedEvent() {
//        competitiveEvents = realm.objects(CompetitiveEvents.self).filter("")
//    }
//    func setTextValues() {
//        typeLabel.text = competitiveEvents?.first?.name
//
//    }
//
}
