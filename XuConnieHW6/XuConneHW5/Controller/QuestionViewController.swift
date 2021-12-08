//
//  ViewController.swift
//  XuConneHW5
//
//  Created by Connie Xu on 10/12/21.
//

import UIKit

class QuestionViewController: UIViewController {

    //IBOutlet
    @IBOutlet weak var messageLabel: UILabel!
    
    //vars
    private var flashcards: FlashcardsModel!
    private var isQuestion: Bool! = true
    private let emptyFlashcard = Flashcard(question: "There are no more flashcards.", answer: "Please add more flashcards.")
    
    var currentFlashcard = Flashcard(question: "", answer: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashcards = flashcardsData.flashcardsModel
        self.messageLabel.text = flashcards.flashcard(at: 0)?.getQuestion()
        
        print("question view controller")
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDidRecognized(_:)))
//        self.view.addGestureRecognizer(tap)

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapDidRecognized(_:)))
        doubleTap.numberOfTapsRequired = 2
//        self.view.addGestureRecognizer(doubleTap)
        
        tap.require(toFail: doubleTap)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftDidRecognized))
        swipeLeft.direction = .left
//        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightDidRecognized))
        swipeRight.direction = .right
//        self.view.addGestureRecognizer(swipeRight)
        
        messageLabel.addGestureRecognizer(tap)
        messageLabel.addGestureRecognizer(doubleTap)
        messageLabel.addGestureRecognizer(swipeLeft)
        messageLabel.addGestureRecognizer(swipeRight)
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(false)
        if(flashcards.numberOfFlashcards() == 0){
            currentFlashcard = emptyFlashcard
        } else {
            currentFlashcard = flashcards.currentFlashcard() ?? emptyFlashcard
        }
        messageLabel.text = currentFlashcard.getQuestion()
        messageLabel.textColor = UIColor.black
    }

    //@IBAction func tapDidRecognized(_ sender: UITapGestureRecognizer) {
    @objc func tapDidRecognized(_ tap: UIGestureRecognizer) {
        print("\(#function)")
        
        let firstAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: transformUp)
        firstAnimator.addCompletion { (position) in
            self.messageLabel.text = self.flashcards.randomFlashcard()?.getQuestion()
            self.messageLabel.textColor = UIColor.black
            self.messageLabel.font = UIFont(name: "DIN Alternate", size: 34)
            let animator = UIViewPropertyAnimator(duration: 0.5, curve: UIView.AnimationCurve.linear, animations: {() in
                self.transformBack()
            })
            animator.startAnimation()
        }
        firstAnimator.startAnimation()
        
        isQuestion = true
    }
    
    //@IBAction func doubleTapDidRecognized(_ sender: UITapGestureRecognizer) {
    @objc func doubleTapDidRecognized(_ doubleTap: UITapGestureRecognizer) {
        print("\(#function)")
        
        if isQuestion {
            if(flashcards.numberOfFlashcards() == 0){
                currentFlashcard = emptyFlashcard
                
                messageLabel.text = currentFlashcard.getAnswer()
                messageLabel.textColor = UIColor.blue
            }
            let firstAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: fadeOutLabel)
            firstAnimator.addCompletion { (position) in
                self.messageLabel.text = self.flashcards.currentFlashcard()?.getAnswer()
                self.messageLabel.textColor = UIColor.blue
                self.messageLabel.font = UIFont(name: "Helvetica Neue", size: 34)
                let animator = UIViewPropertyAnimator(duration: 0.5, curve: UIView.AnimationCurve.linear, animations: {() in
                    self.fadeInLabel()
                })
                animator.startAnimation()
            }
            firstAnimator.startAnimation()
            isQuestion = false
        }
        else {
            let firstAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: fadeOutLabel)
            firstAnimator.addCompletion { (position) in
                self.messageLabel.text = self.flashcards.currentFlashcard()?.getQuestion()
                self.messageLabel.textColor = UIColor.black
                self.messageLabel.font = UIFont(name: "DIN Alternate", size: 34)
                let animator = UIViewPropertyAnimator(duration: 0.5, curve: UIView.AnimationCurve.linear, animations: {() in
                    self.fadeInLabel()
                })
                animator.startAnimation()
            }
            firstAnimator.startAnimation()
            isQuestion = true
        }
    }
    
    @IBAction func swipeLeftDidRecognized(_ sender: UISwipeGestureRecognizer) {
        print("\(#function)")
        
        let firstAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: transformLeft)
        firstAnimator.addCompletion { (position) in
            self.messageLabel.text = self.flashcards.nextFlashcard()?.getQuestion()
            self.messageLabel.textColor = UIColor.black
            self.messageLabel.font = UIFont(name: "DIN Alternate", size: 34)
            let animator = UIViewPropertyAnimator(duration: 0.5, curve: UIView.AnimationCurve.linear, animations: {() in
                self.transformBack()
            })
            animator.startAnimation()
        }
        firstAnimator.startAnimation()
        isQuestion = true
    }
    
    @IBAction func swipeRightDidRecognized(_ sender: UISwipeGestureRecognizer) {
        print("\(#function)")
        
        let firstAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: transformRight)
        firstAnimator.addCompletion { (position) in
            self.messageLabel.text = self.flashcards.previousFlashcard()?.getQuestion()
            self.messageLabel.textColor = UIColor.black
            self.messageLabel.font = UIFont(name: "DIN Alternate", size: 34)
            let animator = UIViewPropertyAnimator(duration: 0.5, curve: UIView.AnimationCurve.linear, animations: {() in
                self.transformBack()
            })
            animator.startAnimation()
        }
        firstAnimator.startAnimation()
        isQuestion = true
    }
    
    //functions for animate
    let screen = UIScreen.main.bounds
    
    func transformUp() {
        messageLabel.transform = CGAffineTransform(translationX: 0, y: -screen.size.height)
    }
    
    func transformBack() {
        messageLabel.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    func transformLeft() {
        messageLabel.transform = CGAffineTransform(translationX: -screen.size.width, y: 0)
    }
    
    func transformRight() {
        messageLabel.transform = CGAffineTransform(translationX: screen.size.width, y: 0)
    }
    
    func fadeOutLabel() {
        messageLabel.alpha = 0
    }
    
    func fadeInLabel() {
        messageLabel.alpha = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

