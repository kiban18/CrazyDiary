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

private let code = """
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

if let editing = editingEntry {
editing.text = textView.text
diary.update(editing)
} else {
//let entry: Entry = Entry(id: UUID(), createdAt: Date(), text: textView.text)
let entry: Entry = Entry(text: textView.text)
diary.add(entry)
editingEntry = entry
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
"""

class EntryViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
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
    
    @objc func keyboardWillShow(note: Notification) {
        print("키보드 등장")
        
        guard
            let userInfo = note.userInfo,
            let keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }
        
        let keyboardHeight: CGFloat = keyboardFrameValue.cgRectValue.height
        print("show duration: \(duration)")
        
        UIView.animate(withDuration: 0.05) {
            self.view.layoutIfNeeded()
            self.textViewBottomConstraint.constant = -keyboardHeight
        }
    }

    @objc func keyboardWillHide(note: Notification) {
        print("키보드 퇴장")
        
        guard
            let userInfo = note.userInfo,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }

        print("hide duration: \(duration)")

        UIView.animate(withDuration: 3.0) {
            self.view.layoutIfNeeded()
            self.textViewBottomConstraint.constant = 0
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)

        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        //textView.text = "처음 쓴 일기..."
        textView.text = code
        textView.backgroundColor = .red
        saveButton.setTitle("저장하기", for: .normal)
        
        textView.becomeFirstResponder()
        
        saveButton.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(note:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(note:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
}
