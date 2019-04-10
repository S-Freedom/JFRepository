//
//  ViewController.swift
//  JFCompiler
//
//  Created by 黄鹏飞 on 2019/4/2.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person : JRPerson = JRPerson()
        person.say(name: "jack")
        
        let nameLbl : UILabel = UILabel()
        nameLbl.text = "jackha1111哒哒哒哒哒哒111111"
        nameLbl.backgroundColor = UIColor.red
        nameLbl.frame = CGRect(x: 100,y: 100,width: 200,height: 200)
        self.view.addSubview(nameLbl)
    }
    
    @objc func injected(){
        print("xxxxxxxxxxxxxxxxxx injected is installed")
    }
}

