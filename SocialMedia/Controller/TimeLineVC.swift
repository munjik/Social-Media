//
//  TimeLineVC.swift
//  SocialMedia
//
//  Created by Munji on 7/23/18.
//  Copyright © 2018 Munji. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class TimeLineVC: UIViewController, UITableViewDelegate, UITableViewDataSource, /* delegates for UIPicker*/ UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImage: CircleView!
    @IBOutlet weak var captionField: CleanField!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var imagesSelected = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true //crops images and stuff thats it
        imagePicker.delegate = self
        
        
        // this code will print out our data in reference to the REF_POST, so all the data under there will be called
        DataServices.ds.REF_POST.observe(.value) { (snapshot) in
            //getting all the data of the child of posts
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for i in snapshot {
                    print("SNAP: \(i)")
                    /// if it can grab the Key on Firebase
                    if let postDict = i.value as? Dictionary<String, AnyObject> {
                        ///The key of the location that generated this FIRDataSnapshot
                        let key = i.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
                self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    // setting our tableViews stuff to be efficent with the DQReusable. 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostingCell") as? PostingCell {
            
            if let img = TimeLineVC.imageCache.object(forKey: post.imageURL  as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
            
        } else {
            return PostingCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    /* Make sure caption is added */
    @IBAction func postBtnTapped(_ sender: Any) {
        guard let caption = captionField.text , caption != "" else {
            print("please add a caption")
            return
        }
        /* we use gurad to strictly make sure we have an image, same as above with caption */
        guard let img = addImage.image, imagesSelected == true else {
            print("please add an image to complete post")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            //unique ID for downloading pictures
            let imgUid = NSUUID().uuidString
            // telling firebase we wanna jpeg
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataServices.ds.REF_IMAGES.child(imgUid).putData(imgData, metadata: metadata) { (metadata, error) in
             
                
                if error != nil {
                    print("Munji: Unable to upload images to Firebase storage")
                } else {
                    print("Munji: image uploaded to firebase storage")
                    // this allows us to upload the photo to firebas storage
                     let downloadURL = StorageReference.downloadURL(completion:)
                    
                }
            }
        }
    }
    
    // When sign out button is pressed we will go back to the login page
    @IBAction func signOutPressed(_ sender: Any) {
        // removing the keychain
       let removeKeychain =  KeychainWrapper.standard.remove(key: KEY_UID)
        print("Munji: ID removed from keychain\(removeKeychain)")
        //sign out with firebase
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
        
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // once we've selected the image picker get rid of it. Simple
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /*Making sure we return an image, "edited Image" because we allow them to edit
         and we make sure it's type UIImage because ->c"as? UIImage" we need to return an image*/
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            // then set it to our image, it shows a preview when you're about to psot 
            addImage.image = image
            imagesSelected = true
        } else {
            print("Munji: A valid Image was not selected, please try again")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
}












