//
//  CircleView.swift
//  SocialMedia
//
//  Created by Munji on 7/25/18.
//  Copyright © 2018 Munji. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
            layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: SHADOW_GRAY).cgColor
            layer.shadowOpacity = 1.0
            layer.shadowRadius = 5.0
            layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            
        
    }

  
    override func draw(_ _rect: CGRect) {
        super.draw(_rect)
        layer.cornerRadius = self.frame.width / 2
    }
}
