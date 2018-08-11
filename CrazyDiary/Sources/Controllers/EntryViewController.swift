//
//  EntryViewController.swift
//  CrazyDiary
//
//  Created by LeeKihwan on 27/07/2018.
//  Copyright © 2018 Crazy Up Inc. All rights reserved.
//

import UIKit

extension DateFormatter {
    static var entryDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy. MM. dd. EEE"
        return df
    }()
    static var entryTimeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "a h:mm:ss"
        return df
    }()
}

class EntryViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var diary: Diary = InMemoryDiary()
    var editingEntry: Entry?
    var tempCount: Int = 0
    
    @objc func saveEntry(_ sender: Any) {
        print(#function)
        tempCount += 1
        textView.text = textView.text + " \(tempCount)"
        
        if let editing = editingEntry {
            editing.text = textView.text
            diary.update(editing)
            timeLabel.text = "\(DateFormatter.entryTimeFormatter.string(from: editing.createdAt)) 생성, \(DateFormatter.entryTimeFormatter.string(from: editing.modifiedAt!)) 수정"
        } else {
            //let entry: Entry = Entry(id: UUID(), createdAt: Date(), text: textView.text)
            let entry: Entry = Entry(text: textView.text)
            diary.add(entry)
            editingEntry = entry
            timeLabel.text = "\(DateFormatter.entryTimeFormatter.string(from: entry.createdAt)) 생성"
        }

        textView.resignFirstResponder()
        textView.isEditable = false
        textView.isSelectable = false
        
        saveButton.removeTarget(self, action: nil, for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(editEntry(_:)), for: .touchUpInside
        )
        saveButton.setTitle("수정하기", for: .normal)
        
        //print("number of entries: ", diary.recentEntries(max: 10).count)
        print("number of entries: ", diary.numberOfEntries)
        let entries = diary.recentEntries(max: Int.max)
//        entries.forEach { (entry) in
//            print("id: \(entry.id), created: \(entry.createdAt), modified: \(entry.modifiedAt), text: \(entry.text)")
//        }
    }
    
    @objc func editEntry(_ sender: Any) {
        print(#function)
        textView.isEditable = true
        textView.becomeFirstResponder()
        
        saveButton.removeTarget(self, action: nil, for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
        
        saveButton.setTitle("저장하기", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)

        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = "처음 쓴 일기..."
        saveButton.setTitle("저장하기", for: .normal)
        
        textView.becomeFirstResponder()
        
        saveButton.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
    }
}
