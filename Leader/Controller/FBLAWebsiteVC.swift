//
//  FBLAWebsiteVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/26/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class FBLAWebsiteVC : UIViewController, SFSafariViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openURL(_ sender: Any) {
        guard let url = URL(string: "https://www.fbla-pbl.org/competitive-event/mobile-application-development-fbla/") else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    controller.dismiss(animated: true, completion: nil)
    }
}
    

