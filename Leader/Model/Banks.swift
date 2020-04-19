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
        questions.append(Question(questions: "How do I add competitive events?", answers: "Go to competitive events, click on an event, and when you scroll down, there should be a blue and yellow plus. Click there to add that event to your list!"))
        questions.append(Question(questions: "How do I delete my signed up events?", answers: "Just swipe left"))
        questions.append(Question(questions: "Why can’t I add teammates to your events screen?", answers: "That feature is currently in development. In the meantime, please add teammates in the teammates field when you submit your events."))
        //Membership
        questions.append(Question(questions: "How do I become a paid member?", answers: "Pay your chapter’s fee at your school’s cashier, then send your receipt to your advisor and your chapter’s officers can change your status on the member’s screen within the Chapter page."))
        questions.append(Question(questions: "What’s the difference between Sign Up and Join FBLA?", answers: "If you are already an FBLA member, you are signing up for Leader, not FBLA. Join FBLA lets you contact the advisor of your local chapter to join, and sign up for Leader."))
        
        //Leader 
        questions.append(Question(questions: "Why is the app so slow?", answers: "Our backend service is currently running for free off of Firebase. Our developer is in the process of finding a better methodology, but in the meantime please be patient. If the screen isn’t loading at all, or you are experiencing other abnormal behavior, please file a bug by clicking the bug report button in settings!"))
        questions.append(Question(questions: "My questions haven’t been answered, how can I get answers?", answers: "If you go to the Contact Us screen, accessible through Settings, you can find our developer’s contact info at the bottom. Please email them with any questions, and our team will work to get you an answer."))
        
        //Passwords 
        questions.append(Question(questions: "How can I reset my password?", answers: "Currently, our password reset optionality is within security. You can change your password by clicking edit, then done when you are complete."))
        questions.append(Question(questions: "Why is my password not working?", answers: "Your password is case sensitive, or there may be more malevolent issues at hand. If further attempts fail, please contact our developer at tarynneal10@gmail.com to reset your account email and password, so you can change them as you please."))
        questions.append(Question(questions: "Someone stole my password.", answers: "Well, that’s rather rude of them. If you still have account access, please reset your password. If not, please contact us at tarynneal10@gmail.com to rectify this issue."))
        
    }
}
