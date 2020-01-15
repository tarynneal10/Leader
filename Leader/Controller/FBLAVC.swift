//
//  FBLAViewController.swift
//  Leader
//
//  Created by Taryn Neal on 7/24/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit


class FBLAVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCurrentEvents" {
        // get a reference to the second view controller
        let secondViewController = segue.destination as! CurrentEventsVC
        
        // set a variable in the second view controller with the String to pass
        //secondViewController.receivedString = "IDk"
        }
    }
}
