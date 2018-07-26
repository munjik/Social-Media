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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostingCell") as! PostingCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
