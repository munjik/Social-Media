//
//  CleanView.swift
//  SocialMedia
//
//  Created by Munji on 7/6/18.
//  Copyright © 2018 Munji. All rights reserved.
//

// We have to pick a part of the interface on the main.storyboard where we want this effect to happen. We choose the view where the logo is placed and changed the class to cleanview to give it this effect
/* Another important info to note is that our two "Views" in the second View Controller has these attributes. We put "CleanView" under their attributes inspectors to acheive this design frame coded below */

import UIKit

class CleanView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // SHADOWGRAY comes from the constants class that we made
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: SHADOW_GRAY).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
        
    }
}
