//
//  SettingsTableModel.swift
//  Leader
//
//  Created by Taryn Neal on 8/2/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//
//So this VC is gonna host ish like current events, competitive events, and whatever else I stick a table view in- remember to convert settings to buttons based VC once current events works
import Foundation
//import RealmSwift

//Example Code:
//class Item: Object {
//    @objc dynamic var title : String = ""
//    @objc dynamic var done : Bool = false
//    @objc dynamic var dateCreated : Date?
//
//    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
//
//}
//class Category: Object {
//    @objc dynamic var name : String = ""
//    @objc dynamic var color: String = ""
//    let items = List<Item>()
//}
//class CurrentEvent : Object {
//    @objc dynamic var eventTitle : String = ""
//    @objc dynamic var eventDate : String = ""
//    @objc dynamic var eventDescription : String = ""
//    @objc dynamic var eventCreator : String = ""
//    var parentChapter = LinkingObjects(fromType: Chapter.self, property: "currentEvents")
//}
//
//class CompetitiveEvents : Object {
//    @objc dynamic var name : String = ""
//    @objc dynamic var type : String = ""
//    @objc dynamic var category : String = ""
//  //  let details = List<CompetitiveEventDetails>()
//}
////class CompetitiveEventDetails : Object {
////    @objc dynamic var overview : String = ""
////}
////struct ColorsConfig {
////    static let selectedText = UIColor.white
////    static let text = UIColor.black
////    static let textDisabled = UIColor.gray
////    static let selectionBackground = UIColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)
////    static let sundayText = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
////    static let sundayTextDisabled = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
////    static let sundaySelectionBackground = sundayText
////}
