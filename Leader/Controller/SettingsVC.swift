//
//  SettingsViewController.swift
//  Leader
//
//  Created by Taryn Neal on 7/23/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
//import Realm
//import RealmSwift

class SettingsVC : UIViewController {
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    //let chapter = Chapter()
    //let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.image = UIImage(named: "Logo2")
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
