//
//  SettingsViewController.swift
//  Leader
//
//  Created by Taryn Neal on 7/23/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class SettingsVC : UIViewController {
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.image = UIImage(named: "Logo2")
      //  db = Firestore.firestore()
        //This code works to get a field from a specific document in firestore & project it
//        let docRef = db.collection("chapter").document("MarysvilleGetchell")
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//                self.testLabel.text = document.get("name") as? String
//            } else {
//                print("Document does not exist")
//            }
//        }
      //  let chapterName = realm.objects(Chapter.self).filter("name like 'Marysville Getchell'")
       // print(chapterName.first as Any)
       // testLabel.text = chapterName.first?.name
        //nameLabel.text = ""
        // Do any additional setup after loading the view.
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
//        navigationItem.leftBarButtonItem = backButton
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.navigationItem.setHidesBackButton(true, animated: true)
//        self.navigationItem.setLeftBarButtonItems(nil, animated: true)
//        self.navigationItem.setHidesBackButton(true, animated:true)
        //self.navigationItem.setHidesBackButton(true, animated: false)
        //code commented out in did load and appear more for when activating push segue in code- for later
        //navigationController?.navigationBar.topItem?.hidesBackButton = true

    }
    @IBOutlet weak var testLabel: UILabel!
    
}
