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

class TimeLineVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
