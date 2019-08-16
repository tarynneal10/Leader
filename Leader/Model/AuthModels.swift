//
//  AuthModels.swift
//  Leader
//
//  Created by Taryn Neal on 8/7/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import RealmSwift

class Chapter : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var done : Bool = true
    @objc dynamic var dateCreated : Date?
    let members = List<Member>()
    let currentEvents = List<CurrentEvent>()
    override static func primaryKey() -> String? {
        return "name"
    }
}

class Member : Object {
    @objc dynamic var firstName : String = ""
    @objc dynamic var lastName : String = ""
    
    //The var from here down member does need- but are should they be here or somewhere else
    @objc dynamic var position : String = ""
    @objc dynamic var attendance : String = ""
    @objc dynamic var profilePhoto : String = ""
    @objc dynamic var profileBio : String = ""
    @objc dynamic var awards : String = ""
    var parentChapter = LinkingObjects(fromType: Chapter.self, property: "members")
}
