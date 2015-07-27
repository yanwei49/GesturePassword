//
//  PasswordView.swift
//  GesturePassword
//
//  Created by 颜魏 on 15/7/24.
//  Copyright © 2015年 颜魏. All rights reserved.
//

import UIKit

protocol PasswordViewDelegate {
    func passwordViewEndInputPassword(password: String)
}

class PasswordView: UIView {

    let btnW: CGFloat = 70
    let btnH: CGFloat = 70
    let width: CGFloat = UIScreen.mainScreen().bounds.width
    var btnsArray = [UIButton]()
    var currentPoint: CGPoint?
    
    var delegate: PasswordViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        //创建布局
        createNineLayout()
    }

    func createNineLayout() {
        
        let space: CGFloat = (width - 3*70)/4
        let btnX = space + btnW
        let btnY = UIScreen.mainScreen().bounds.height/2 - space - btnH/2*3
        
        for i in 0 ..< 9 {
            let row = i/3
            let line = i%3
            let btn = UIButton(frame: CGRectMake(CGFloat(line)*btnX+space, btnY+CGFloat(row)*(space+btnH), btnW, btnH))
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 35
            btn.layer.borderColor = UIColor.purpleColor().CGColor
            btn.layer.borderWidth = 3
            btn.tag = 100+i
            btn.backgroundColor = UIColor.greenColor()
            btn.setBackgroundImage(UIImage(named: ""), forState: .Normal)
            btn.setBackgroundImage(UIImage(named: ""), forState: .Selected)
            btn.userInteractionEnabled = false
            
            self.addSubview(btn)
        }
        
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        let touch = touches.first! as UITouch
        let point = touch.locationInView(self)

        for btn in self.subviews {
            if btn.isKindOfClass(UIButton.classForCoder()) {
                let button = btn as! UIButton
                if CGRectContainsPoint(button.frame, point) && !button.selected {
                    button.selected == true
                    button.backgroundColor = UIColor.redColor()
                    btnsArray.append(button)
                }
            }
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        let point = touch.locationInView(self)
        
        for btn in self.subviews {
            if btn.isKindOfClass(UIButton.classForCoder()) {
                let button = btn as! UIButton
                if CGRectContainsPoint(button.frame, point) && !button.selected {
                    if btn == btnsArray.last {
                        return
                    }
                    button.selected = true
                    button.backgroundColor = UIColor.redColor()
                    btnsArray.append(button)
                    self.setNeedsDisplay()
                }else {
                    currentPoint = point
                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for i in 0 ..< btnsArray.count {
            let btn = btnsArray[i] as UIButton
            btn.selected = false
            btn.backgroundColor = UIColor.greenColor()
        }
        var password: String = ""
        for i in 0 ..< btnsArray.count {
            let btn = btnsArray[i]
            password += "\(btn.tag-100)"
        }
        btnsArray.removeAll()
        self.setNeedsDisplay()
        delegate?.passwordViewEndInputPassword(password)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
    }
    
    override func drawRect(rect: CGRect) {
        if btnsArray.count != 0 {
            let bezier = UIBezierPath()
            bezier.lineWidth = 10
            bezier.lineJoinStyle = kCGLineJoinRound
            UIColor(red: 0.2, green: 0.5, blue: 0.7, alpha: 0.5).set()
            for i in 0 ..< btnsArray.count {
                let btn = btnsArray[i] as UIButton
                if i == 0 {
                    bezier.moveToPoint(btn.center)
                }else {
                    bezier.addLineToPoint(btn.center)
                }
            }
//            bezier.addLineToPoint(currentPoint!)
            bezier.stroke()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
