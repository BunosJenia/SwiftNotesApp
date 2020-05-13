//
//  DIsplayNoteViewController.swift
//  Notes
//
//  Created by Yauheni Bunas on 5/12/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import UIKit

class DIsplayNoteViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    
    var note: Note?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "save" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""
            note?.modifiedTime = Date()
            
            CoreDataHelper.saveNote()
        case "save" where note == nil:
            let note = CoreDataHelper.newNote()
            
            note.title = titleTextField.text ?? ""
            note.content = contentTextView.text ?? ""
            note.modifiedTime = Date()
            
            CoreDataHelper.saveNote()
        case "cancel":
            print("cancel bar button item tapped")

        default:
            print("unexpected segue identifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note {
            titleTextField.text = note.title
            contentTextView.text = note.content
        } else {
            titleTextField.text = ""
            contentTextView.text = ""
        }
        
    }
}
