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
    var passedValue = ""
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
              let contentWidth = scrollView.bounds.width
                let contentHeight = scrollView.bounds.height * 3
                scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
         
                let subviewHeight = CGFloat(120)
                var currentViewOffset = CGFloat(0);

                while currentViewOffset < contentHeight {
                let frame = CGRect(x: 0, y: currentViewOffset, width: contentWidth, height: contentHeight).insetBy(dx: 5, dy: 5)

                let subview = UIView(frame: frame)
        //            //subview.backgroundColor = UIColor.orange
                    //subView = UIView(frame: frame)
                scrollView.addSubview(subview)

                currentViewOffset += subviewHeight
                }
       // loadCompetitiveEvents()
        db = Firestore.firestore()
        DocRef = db.collection("competitiveevents").whereField("name", isEqualTo: passedValue)
       // nameLabel.text = passedValue
        loadDetails()
        //print("\(String(describing: passedValue))")
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
                    let type = document.get("type") as? String
                    let category = document.get("category") as? String
                    let overview = document.get("overview") as? String
                    
                    self.categoryLabel.text = "Category: \(category!)"
                    self.typeLabel.text = "Type: \(type!)"
                    self.nameLabel.text = name
                    self.overviewLabel.text = overview
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
