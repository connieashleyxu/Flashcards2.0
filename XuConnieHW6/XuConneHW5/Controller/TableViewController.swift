//
//  TableViewController.swift
//  XuConneHW5
//
//  Created by Connie Xu on 11/3/21.
//

import Foundation

import UIKit

class TableViewController: UITableViewController {

    private var flashcards: FlashcardsModel!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashcardsData.flashcardsModel.numberOfFlashcards()
//        return flashcardsModel.numberOfFlashcards()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel!.text = flashcardsData.flashcardsModel.flashcards[indexPath.row].getQuestion()
        cell.detailTextLabel!.text = flashcardsData.flashcardsModel.flashcards[indexPath.row].getAnswer()
        
//        cell.textLabel!.text = flashcardsModel.flashcards[indexPath.row].question!

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            flashcardsData.flashcardsModel.removeFlashcard(at: indexPath.row)
            flashcardsData.flashcardsModel.save()
            
//            flashcardsModel.removeFlashcard(atIndex: indexPath.row)
//            flashcardsModel.save()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addQuestionVc = segue.destination as? AddViewController{
            
            addQuestionVc.onComplete = {() in
                // Refresh the list
                self.tableview.reloadData()
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        flashcardsData.flashcardsModel.rearrangeFlashcards(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
}
