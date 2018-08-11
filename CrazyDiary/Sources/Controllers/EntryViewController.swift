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
}

class EntryViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var diary: Diary = InMemoryDiary()
    var tempCount: Int = 0
    
    @IBAction func saveEntry(_ sender: Any) {
        tempCount += 1
        textView.text = textView.text + " \(tempCount)"
        //let entry: Entry = Entry(id: UUID(), createdAt: Date(), text: textView.text)
        let entry: Entry = Entry(text: textView.text)
        diary.add(entry)

        textView.resignFirstResponder()
        textView.isEditable = false
        textView.isSelectable = false
        
        //print("number of entries: ", diary.recentEntries(max: 10).count)
        print("number of entries: ", diary.numberOfEntries)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //dateLabel.text = "2020. 11. 22. 금요일"
        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = "IBOutlet으로 연결한 TextView"
        saveButton.setTitle("완전저장", for: .normal)
        
        textView.becomeFirstResponder()
    }
}
