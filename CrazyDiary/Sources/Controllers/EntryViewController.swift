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
    
    @objc func saveEntry(_ sender: Any) {
        print(#function)
        tempCount += 1
        textView.text = textView.text + " \(tempCount)"
        //let entry: Entry = Entry(id: UUID(), createdAt: Date(), text: textView.text)
        let entry: Entry = Entry(text: textView.text)
        diary.add(entry)

        textView.resignFirstResponder()
        textView.isEditable = false
        textView.isSelectable = false
        
        saveButton.removeTarget(self, action: nil, for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(editEntry(_:)), for: .touchUpInside
        )
        saveButton.setTitle("수정하기", for: .normal)
        
        //print("number of entries: ", diary.recentEntries(max: 10).count)
        print("number of entries: ", diary.numberOfEntries)
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

        //dateLabel.text = "2020. 11. 22. 금요일"
        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = "IBOutlet으로 연결한 TextView"
        saveButton.setTitle("저장하기", for: .normal)
        
        textView.becomeFirstResponder()
        
        saveButton.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
    }
}
