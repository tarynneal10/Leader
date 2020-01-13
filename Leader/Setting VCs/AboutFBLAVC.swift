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

class AboutFBLAVC : UIViewController, SFSafariViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var fblaText = ["Develop competent, aggressive business leadership.", "Strengthen the confidence of students in themselves and their work.", "Create more interest in and understanding of American business enterprise.", "Encourage members in the development of individual projects that contribute to the improvement of home, business, and community.", "Develop character, prepare for useful citizenship, and foster patriotism.", "Encourage and practice efficient money management.", "Encourage scholarship and promote school loyalty.", "Assist students in the establishment of occupational goals.", "Facilitate the transition from school to work."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 42.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fblaText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath as IndexPath) as! AboutFBLACell
        cell.label.text = fblaText[indexPath.row]
        return cell
    }
    
    @IBAction func openFBLA(_ sender: Any) {
        guard let url = URL(string: "https://www.fbla-pbl.org/") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    @IBAction func openFacebook(_ sender: Any) {
        guard let url = URL(string: "https://www.facebook.com/FutureBusinessLeaders/") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    @IBAction func openTwitter(_ sender: Any) {
        guard let url = URL(string: "https://twitter.com/fbla_national?lang=en") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    @IBAction func openInstagram(_ sender: Any) {
        guard let url = URL(string: "https://www.instagram.com/fbla_pbl/?hl=en") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
}
class AboutFBLACell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
}
