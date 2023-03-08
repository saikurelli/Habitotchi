//
//  RoundButton.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/7/23.
//

import UIKit

@IBDesignable class RoundButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
    
    private func commonInit(){
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
