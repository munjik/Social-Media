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

class TimeLineVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
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
                        self.posts.append(post)                    }
                    
                }
            }
                self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        print("Munj: \(post.caption)")
        
        return tableView.dequeueReusableCell(withIdentifier: "PostingCell") as! PostingCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
}
