//
//  CoreDataHelper.swift
//  Notes
//
//  Created by Yauheni Bunas on 5/13/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        
        return note
    }
    
    static func saveNote() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func deleteNote(_ note: Note) {
        context.delete(note)
        
        saveNote()
    }
    
    static func retrieveNotes() -> [Note] {
        do {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            var results = try context.fetch(fetchRequest)
            
            results.sort(by: { $0.modifiedTime!.timeIntervalSince1970 > $1.modifiedTime!.timeIntervalSince1970 })
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")

            return []
        }
    }
}
