//
//  XuConneHW5Tests.swift
//  XuConneHW5Tests
//
//  Created by Connie Xu on 10/12/21.
//

import XCTest
@testable import XuConneHW5

class XuConneHW5Tests: XCTestCase {
    
    private var flashcards: FlashcardsModel!
    
    override func setUp() {
        super.setUp()
        flashcards = FlashcardsModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertEqual(flashcards.flashcards[0].answer, "2")
        XCTAssertEqual(flashcards.flashcards[1].answer, "4")
        XCTAssertEqual(flashcards.flashcards[2].answer, "6")
        XCTAssertEqual(flashcards.flashcards[3].answer, "8")
        XCTAssertEqual(flashcards.flashcards[4].answer, "10")
    }
    
    func testNumberOfFlashcards() {
        XCTAssertEqual(flashcards.numberOfFlashcards(), 5)
    }
    
    func testRandomFlashcard() {
        var flashcard1: Flashcard!
        var flashcard2: Flashcard!
        flashcard1 = flashcards.currentFlashcard()
        flashcard2 = flashcards.randomFlashcard()
        XCTAssertNotEqual(flashcard1.question, flashcard2.question)
    }
    
    func testNextFlashcard() {
        XCTAssertEqual(flashcards.nextFlashcard()?.answer, "4")
    }
    
    func testPreviousFlashcard() {
        XCTAssertEqual(flashcards.previousFlashcard()?.answer, "10")
    }
    
//    func testInsertWithoutIndex() {
//        flashcards.insert(question: "Question 1", answer: "Answer 1", favorite: false)
//        XCTAssertEqual(flashcards.flashcards[flashcards.flashcards.count-1].answer, "Answer 1")
//    }
    
    func testInsertWithIndex() {
        flashcards.insert(question: "Question 2?", answer: "Answer 2", favorite: false, at: 0)
        XCTAssertEqual(flashcards.flashcards[0].answer, "Answer 2")
    }
    
    func testCurrentFlashcard() {
        XCTAssertEqual(flashcards.currentFlashcard()?.question, flashcards.currentFlashcard()?.question)
    }
    
    func testFlashcard() {
        XCTAssertEqual(flashcards.flashcard(at: 4)?.answer, "10")
    }
    
    func testRemoveFlashcardWithIndex() {
        var original: String!
        var new: String!
        original = flashcards.flashcards[0].answer
        flashcards.removeFlashcard(at: 0)
        new = flashcards.flashcards[0].answer
        XCTAssertNotEqual(original, new)
    }
    
    func testToggleFavorite() {
        var original: Bool!
        var new: Bool!
        original = flashcards.currentFlashcard()?.isFavorite
        flashcards.toggleFavorite()
        new = flashcards.currentFlashcard()?.isFavorite
        XCTAssertNotEqual(original, new)
    }
    
    func testFavoriteFlashcards() {
        var favorite: [Flashcard]!
        favorite = flashcards.favoriteFlashcards()
        XCTAssertEqual(favorite.contains(where: {$0.isFavorite == false}), false)
    }

}
