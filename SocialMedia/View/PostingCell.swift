//
//  PostingCell.swift
//  SocialMedia
//
//  Created by Munji on 7/25/18.
//  Copyright © 2018 Munji. All rights reserved.
//

import UIKit
import Firebase

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
    // we have a UIImage as an Optional because maybe the images havenet been downloaded yet. Meaning they're just seeing it for the first time and the cahce hasnt loaded
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        /* Where we are downlaoding the images in our configure cell*/
        // if its in the cache
        if img != nil {
            self.postImg.image = img
        } else {
            
            let ref = Storage.storage().reference(forURL: post.imageURL)
            //bringing data to the URL We are passing
            ref.getData(maxSize: 2 * 1024 * 1024  , completion: { (data, error) in
                if error != nil {
                    print("Munji: Unable to download image from Firebase Storage")
                } else {
                    print("Munji: Image downloaded from Firebase storage")
                    // wanna save that data.. saving it to cache
                    if let imgData = data { // getting data from the data in the completion handler mentioned in the "ref.getData" line
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            TimeLineVC.imageCache.setObject(img, forKey: post.imageURL as NSString)
                        }
                        
                    }
                }
                
            })
            
        }
    }
}
