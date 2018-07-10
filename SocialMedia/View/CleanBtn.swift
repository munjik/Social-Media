//
//  CleanBtn.swift
//  SocialMedia
//
//  Created by Munji on 7/9/18.
//  Copyright © 2018 Munji. All rights reserved.
//

import UIKit

class CleanBtn: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: SHADOW_GRAY).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }
        

}
