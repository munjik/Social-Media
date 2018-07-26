//
//  PostingCell.swift
//  SocialMedia
//
//  Created by Munji on 7/25/18.
//  Copyright © 2018 Munji. All rights reserved.
//

import UIKit

class PostingCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



}
