//
//  NotesTableViewCell.swift
//  Notes
//
//  Created by Yauheni Bunas on 5/12/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var modifiedTimestampLabel: UILabel!
    
    static let identifier: String = "NotesTableViewCell"
}
