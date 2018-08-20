//
//  SauceView.swift
//  MultiUseless
//
//  Created by Stefan V. de Moraes on 17/08/2018.
//  Copyright © 2018 Stefan V. de Moraes. All rights reserved.
//

import UIKit

class SauceView: UIView {
    
    override func layoutSubviews() {
       
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        self.layer.borderWidth = 20
    }
 
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
