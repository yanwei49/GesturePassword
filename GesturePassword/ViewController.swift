//
//  ViewController.swift
//  GesturePassword
//
//  Created by 颜魏 on 15/7/24.
//  Copyright © 2015年 颜魏. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PasswordViewDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        let pv = PasswordView()
        pv.frame = view.bounds
        pv.delegate = self
        view.addSubview(pv)
    }
    
    func passwordViewEndInputPassword(password: String) {
        if password == "012345678" {
            let alter = UIAlertController(title: "密码正确", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alter.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alter, animated: true, completion: nil)
        }else {
            let alter = UIAlertController(title: "密码错误", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alter.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alter, animated: true, completion: nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

