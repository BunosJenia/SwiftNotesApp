//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Yauheni Bunas on 5/12/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    var notes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes = CoreDataHelper.retrieveNotes()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier, for: indexPath) as! NotesTableViewCell
        
        let note = notes[indexPath.row]
        noteCell.titleLabel.text = note.title
        noteCell.modifiedTimestampLabel.text = note.modifiedTime?.convertToString() ?? "unknown"
        noteCell.textLabel?.text = note.content

        return noteCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = notes[indexPath.row]
            CoreDataHelper.deleteNote(noteToDelete)
            
            notes = CoreDataHelper.retrieveNotes()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayNote":
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let note = notes[indexPath.row]
            let destination = segue.destination as! DIsplayNoteViewController
            
            destination.note = note
        case "addNote":
            print("create note bar button item tapped")

        default:
            print("unexpected segue identifier")
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        notes = CoreDataHelper.retrieveNotes()
    }
}

extension Date {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
    }
}

extension NSDate {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: (self as Date), dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
    }
}
