//
//  CircularImageViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/7/23.
//

import UIKit

@IBDesignable
class CircularImageView : UIImageView {
        override func layoutSubviews() {
            super.layoutSubviews()
            layer.borderWidth = 1
            layer.masksToBounds = false
            layer.borderColor = GREEN.cgColor
            layer.cornerRadius = self.frame.height / 2
            clipsToBounds = true
        }
    }
