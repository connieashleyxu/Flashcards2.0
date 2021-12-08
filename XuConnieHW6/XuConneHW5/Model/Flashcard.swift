//
//  Flashcard.swift
//  XuConneHW5
//
//  Created by Connie Xu on 10/12/21.
//

import Foundation

struct Flashcard:Equatable, Codable {
    //declare priv var
    private var question: String = ""
    private var answer: String = ""
    
    //declare public var
    var isFavorite: Bool!
    
    //get funcs
//    mutating func getQuestion (question: String) -> String {
//        self.question = question
//        return question
//    }
//
//    mutating func getAnswer (answer: String) -> String {
//        self.answer = answer
//        return answer
//    }
//    public var question: String {
//        get {
//            return self._question;
//        }
//        set {
//            if newValue.isEmpty {
//                fatalError("invalid value for question")
//            } else {
//                self._question = newValue
//            }
//        }
//    }
//
//    public var answer: String {
//        get {
//            return self._answer;
//        }
//        set {
//            if newValue.isEmpty {
//                fatalError("invalid value for answer")
//            } else {
//                self._answer = newValue
//            }
//        }
//    }
    
    public func getQuestion() -> String {
            return question
        }
        public func getAnswer() -> String {
            return answer
        }
    
    //init func
//    init(question: String, answer: String) {
//        self.question = question
//        self.answer = answer
//        self.isFavorite = false
//    }
//
    
//    public init(question: String, answer: String, isFavorite: Bool=false) {
//        self.question = question
//        self.answer = answer
//        self.isFavorite = isFavorite
//    }
    
        var description: String {
            let desc = "\(getQuestion()):\(getAnswer())+"
            return desc
        }
    
    
    init(question: String, answer: String){
        self.question = question
        self.answer = answer
    }
}
    


