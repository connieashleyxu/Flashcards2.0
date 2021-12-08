//
//  FlashcardsModel.swift
//  XuConnieHW5
//

import Foundation

class FlashcardsModel: FlashcardsDataModel {
    static let sharedInstance = FlashcardsModel()
    
    var flashcards: [Flashcard]!
    private(set) var currentIndex: Int!
    private var questionDisplay: Bool
    
    func rearrangeFlashcards(from: Int, to: Int) {
        flashcards.insert(flashcards.remove(at: from), at: to);
        save()
    }
    
    func checkAskedQuestion(potentialQuestion: String) -> Bool {
        for i in flashcards {
            if i.getQuestion().contains(potentialQuestion){
                    return true
                    //true == is same
                }
            }
        return false
    }
    
    init() {
        flashcards = []
        questionDisplay = true
        currentIndex = 0
        flashcards.append(Flashcard(question: "What is 1+1?", answer: "2"))
        flashcards.append(Flashcard(question: "What is 2+2?", answer: "4"))
        flashcards.append(Flashcard(question: "What is 3+3?", answer: "6"))
        flashcards.append(Flashcard(question: "What is 4+4?", answer: "8"))
        flashcards.append(Flashcard(question: "What is 5+5?", answer: "10"))
    
        
        do {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                            .userDomainMask, true)
            let documentsDirectory = paths.first!
            let filePath = "\(documentsDirectory)/Flashcards.plist"
            print(filePath)
            
            let data = try String(contentsOfFile: filePath, encoding: .utf8)
            let myStrings = data.components(separatedBy: .symbols)
            for line in myStrings {
                if line.contains(":") {
                    //let attributes = line.split(separator: ":")
                    //let flashcard = Flashcard(question: String(attributes[0]),
                                              //answer: String(attributes[1]))
                    //flashcards.append(flashcard)
                }
            }
            if(flashcards.count == 0) {
                flashcards.append(Flashcard(question: "There are no more flashcards.", answer: "Please add more flashcards."))
            }
        } catch {
            print("Could not read file")

        }
    }
    
    func save() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let documentsDirectory = paths.first!
        let filePath = "\(documentsDirectory)/Flashcards.plist"
        print(filePath)
        
        var cardsString:String = String()
        for item in flashcards {
            let desc: String! = item.description
            cardsString.append(desc)
        }
        do {
            try cardsString.write(toFile: filePath,
                                   atomically: true, encoding: .utf8)
        } catch {
            print("Could not save to file")
        }
    }
    
    func numberOfFlashcards() -> Int {
        return flashcards.count
    }
    
    func randomFlashcard() -> Flashcard? {
        if(flashcards.count == 0){
            flashcards.append(Flashcard(question: "There are no more flashcards.", answer: "Please add more flashcards."))
            return nil
        }
                var index = Int.random(in: 0..<flashcards.count);
                while(index == currentIndex && flashcards.count > 1){
                    // Make sure you get a different flashcard than current
                    index = Int.random(in: 0..<flashcards.count)
                }
                currentIndex = index
                questionDisplay = true
                return flashcards[currentIndex!]
    }
    
    func currentFlashcard() -> Flashcard? {
        //return flashcards[currentIndex]
        guard let index = currentIndex else {
            return nil
        }
        return flashcards[index]
    }
    
    func flashcard(at index: Int) -> Flashcard? {
//        currentIndex = at
//        return flashcards[currentIndex]
        if(index >= 0 && index < flashcards.count){
                    return flashcards[index]
                }
                return nil
    }
    
    func nextFlashcard() -> Flashcard? {
        guard let index = currentIndex else {
                    return nil
                }
                if(index == flashcards.count - 1){
                    currentIndex = 0
                    //REMOVED
                    //flashcards.append(Flashcard(question: "There are no more flashcards.", answer: "Please add more flashcards."))
                } else {
                    currentIndex = currentIndex! + 1
                }
                questionDisplay = true
                return flashcards[currentIndex!]
    }
    
    func previousFlashcard() -> Flashcard? {
        guard let index = currentIndex else {
                    return nil
                }
                if(index == 0){
                    currentIndex = flashcards.count - 1
                    //REMOVED
                    //flashcards.append(Flashcard(question: "There are no more flashcards.", answer: "Please add more flashcards."))
                } else {
                    currentIndex = currentIndex! - 1
                }
                questionDisplay = true
                return flashcards[currentIndex!]
    }
    
//    func insert(question: String, answer: String, favorite: Bool) {
//        let flash = Flashcard(question: question, answer: answer, isFavorite: favorite)
//        flashcards.append(flash)
//        if(flashcard(at: 0)?.question == "There are no more flashcards.") {
//            removeFlashcard(at: 0)
//        }
//    }
    
    func insert(question: String, answer: String, favorite: Bool, at: Int) {
        let flash = Flashcard(question: question, answer: answer /*, isFavorite: favorite*/)
        if at <= flashcards.count && at >= 0 {
            flashcards.insert(flash, at: at)
        }
        if(flashcard(at: 0)?.getQuestion() == "There are no more flashcards.") {
            removeFlashcard(at: 0)
        }
        //ADDED
        if(flashcard(at: 0)?.getAnswer() == "Please add more flashcards.") {
            removeFlashcard(at: 0)
        }
    }
    
    func removeFlashcard() {
        if currentIndex < flashcards.count && currentIndex >= 0{
            flashcards.remove(at: currentIndex)
        }
    }
    
    func removeFlashcard(at index: Int) {
//        if at < flashcards.count && at >= 0{
//            flashcards.remove(at: at)
//        }
        if(!(index >= 0 && index < flashcards.count)){
            return;
        } else {
            flashcards.remove(at: index)
            if(flashcards.count == 0){
                currentIndex = nil
                questionDisplay = true
  
            } else if(index < currentIndex!){
                currentIndex = currentIndex! - 1
            } else if((index == currentIndex) && (currentIndex == (flashcards.count))){
                currentIndex = currentIndex! - 1
                questionDisplay = true
            }
        }
    }
    
    //not implemented yet in storyboard
    func toggleFavorite() {
        flashcards[currentIndex].isFavorite = !flashcards[currentIndex].isFavorite
    }
    
    func favoriteFlashcards() -> [Flashcard] {
        var favFlashcards: [Flashcard]! = []
        for flashcard in flashcards {
            if flashcard.isFavorite {
                favFlashcards.append(flashcard)
            }
        }
        return favFlashcards
    }
}
