//
//  RoundButton.swift
//  SpeechRec
//
//  Created by Claire Mo on 6/9/20.
//  Copyright © 2020 Zongying Mo. All rights reserved.
//

import UIKit
@IBDesignable

class RoundButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 30.0{
        didSet{
            setUpView()
        }
        
    }
    
    func setUpView(){
        layer.cornerRadius = cornerRadius
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
