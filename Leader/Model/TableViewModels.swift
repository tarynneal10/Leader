//
//  SettingsTableModel.swift
//  Leader
//
//  Created by Taryn Neal on 8/2/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//
//So this VC is gonna host ish like current events, competitive events, and whatever else I stick a table view in- remember to convert settings to buttons based VC once current events works

import Foundation
import Firebase
import FirebaseFirestore
//

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

class CurrentEvent {
    
    let name : String
    let date : Timestamp
    let description : String
    
    init (eventName: String, eventDate: Timestamp, eventDescription: String) {
        name = eventName
        date = eventDate
        description = eventDescription
    }
    
}
//Gonna be honest this is just bc I'm too lazy to format the class above for the calendar
class CurrentEventDate {
    let date : String
    init (eventDate: String) {
        date = eventDate
    }
}
class Member {
    let name : String
    
    init (memberName: String) {
        name = memberName
    }
}

class CompetitiveEvent {
    let name : String
    let category : String
    let type : String
    init (eventName: String, eventCategory: String, eventType: String) {
        name = eventName
        category = eventCategory
        type = eventType
    }
}
