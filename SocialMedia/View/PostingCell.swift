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

    var post: Post!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // set the UI Elements to the data
    func configureCell(post: Post) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
    }



}
