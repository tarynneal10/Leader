//
//  AboutFBLAVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/24/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class AboutFBLAVC : UIViewController, SFSafariViewControllerDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let contentWidth = scrollView.bounds.width
        let contentHeight = scrollView.bounds.height * 3
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
 
//        let subviewHeight = CGFloat(120)
//        var currentViewOffset = CGFloat(0);
//
//        while currentViewOffset < contentHeight {
//        let frame = CGRect(x: 0, y: currentViewOffset, width: contentWidth, height: contentHeight).insetBy(dx: 5, dy: 5)
//        
//        let subview = UIView(frame: frame)
//            
//        scrollView.addSubview(subview)
//
//        currentViewOffset += subviewHeight
//        }
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
