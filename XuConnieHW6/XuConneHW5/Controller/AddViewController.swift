//
//  AddViewController.swift
//  XuConneHW5
//
//  Created by Connie Xu on 11/3/21.
//

import Foundation

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var promptLabel: UILabel!
    
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    var onComplete: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Add view controller")
        questionTextView.delegate = self
        answerTextField.delegate = self
        saveButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = event!.allTouches?.first!
        if self.questionTextView.isFirstResponder && touch?.view != self.questionTextView{
            self.questionTextView.resignFirstResponder()
            self.answerTextField.resignFirstResponder()
        }
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func textFieldExit(_ sender: UITextField) {
//        if(self.questionTextView.text.count != 0 && self.answerTextField.text?.count != 0) {
//            saveButton.isEnabled = true
//        }
//        else {
//            saveButton.isEnabled = false
//        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(self.questionTextView.text.count != 0 && self.answerTextField.text?.count != 0) {
            saveButton.isEnabled = true
        }
        else {
            saveButton.isEnabled = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(self.questionTextView.text.count != 0 && self.answerTextField.text?.count != 0) {
            saveButton.isEnabled = true
        }
        else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if flashcardsData.flashcardsModel.checkAskedQuestion(potentialQuestion: questionTextView.text!) == true {
         
            let alert = UIAlertController(title: "Warning!", message: "The question you have entered already exists, try a new question", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            questionTextView.text = ""
            answerTextField.text = ""
            saveButton.isEnabled = false
        }
        else {
            flashcardsData.flashcardsModel.insert(question: questionTextView.text!, answer: answerTextField.text!, favorite: false, at: 0)
//        flashcardsModel.insert(question: questionTextView.text!, answer: answerTextField.text!, favorite: false)
            print("Save Button Pressed")
            flashcardsData.flashcardsModel.save()
//        flashcardsModel.save()
            questionTextView.text = ""
            answerTextField.text = ""
            saveButton.isEnabled = false
        
            if let onComplete = onComplete {
                            onComplete()
                        }
            
            self.dismiss(animated: true, completion: nil)
            
            
//            let question = Flashcard(question: questionTextView.text!, answer: answerTextField.text!)
//            flashcardsData.flashcardsModel.insert(question: questionTextView.text!, answer: answerTextField.text!, favorite: false, at: 0)
//
//            onComplete?(question)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            answerTextField.becomeFirstResponder()
            return false
        }
        return true
    }
}
