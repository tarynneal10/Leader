//
//  CompetitiveEventDetails.swift
//  Leader
//
//  Created by Taryn Neal on 8/23/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CompetitiveEventDetailsVC : UIViewController {
    var db: Firestore!
    var DocRef : Query?
  //  var events: [CompetitiveEvent] = []
    var passedValue : String?
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // loadCompetitiveEvents()
        db = Firestore.firestore()
        DocRef = db.collection("competitiveevents").whereField("name", isEqualTo: passedValue)
        print("\(String(describing: passedValue))")
        setTextValues()
        
    }
    func loadDetails() {
        DocRef?.getDocuments() { (QuerySnapshot, err) in
            if err != nil
            {
                print("Error getting documents: \(String(describing: err))");
            }
            else
            {
                
                for document in QuerySnapshot!.documents {
                    
                    let name = document.get("name") as? String
                    
                    print(document.data())
                }
                
            }
            
        }

        
    }
//    func selectedEvent() {
//        competitiveEvents = realm.objects(CompetitiveEvents.self).filter("")
//    }
    func findEventDetails() {
        
    }
    func setTextValues() {
//        typeLabel.text = competitiveEventsDetails?.first?.type
//        categoryLabel.text = competitiveEventsDetails?.first?.category
//        nameLabel.text = competitiveEventsDetails?.first?.name
////Should probs set up a parameter or two for when there's no value
    }
//
}
