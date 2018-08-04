//
//  EntryViewController.swift
//  CrazyDiary
//
//  Created by LeeKihwan on 27/07/2018.
//  Copyright © 2018 Crazy Up Inc. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var model: Int = 0
    
    @IBAction func save(_ sender: Any) {
        model += 1
        dateLabel.text = "\(model)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = "2020. 11. 22. 금요일"
        textView.text = "일기를 코드로 써보기도 합니다."
        saveButton.setTitle("완전저장", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

