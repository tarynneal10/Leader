//
//  Banks.swift
//  Leader
//
//  Created by Taryn Neal on 4/12/20.
//  Copyright © 2020 Taryn Neal. All rights reserved.
//

import Foundation

class FAQBank {
    var questions = [Question]()
    
    init() {
        //Events
        questions.append(Question(questions: "How do I add competitive events?", answers: "Go to competitive events, click on an event, and when you scroll down, there should be a blue and yellow plus. Click there to add that event to your list!", sections: "Events"))
        questions.append(Question(questions: "How do I delete my signed up events?", answers: "Just swipe left", sections: "Events"))
        
        //Membership
        questions.append(Question(questions: "How do I become a paid member?", answers: "Pay your chapter’s fee at your school’s cashier, then send your receipt to your advisor and your chapter’s officers can change your status on the member’s screen within the Chapter page.", sections: "Membership"))
    }
}
