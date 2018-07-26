//
//  CircleView.swift
//  SocialMedia
//
//  Created by Munji on 7/25/18.
//  Copyright © 2018 Munji. All rights reserved.
//

// providing circle looking shapes for the upload image and profile picture
import UIKit

class CircleView: UIImageView {
  
    override func layoutSubviews() {

        layer.cornerRadius = self.frame.width / 2
    }
}
