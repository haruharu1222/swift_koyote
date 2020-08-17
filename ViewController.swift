//
//  ViewController.swift
//  otamesi
//
//  Created by 山口遥陽 on 2020/08/13.
//  Copyright © 2020 山口遥陽. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
//人数
     var NumberOfMembers = 0
    
    @IBAction func NumberOfMembers_3(_ sender: Any) {
        NumberOfMembers = 3
    }
    @IBAction func NumberOfMembers_4(_ sender: Any) {
        NumberOfMembers = 4
    }
    
}

