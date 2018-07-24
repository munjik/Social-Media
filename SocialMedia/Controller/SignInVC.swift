//
//  ViewController.swift
//  SocialMedia
//
//  Created by Munji on 7/5/18.
//  Copyright © 2018 Munji. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    // text fields for sign in
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //SEGUES NEED TO BE PERFORMED HERE NOT viewDidLoad
    override func viewDidAppear(_ animated: Bool) {
        // if it finds the account go straight to the feed
        if let _ =  KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error ) in
            //error handling
            if error != nil {
                print("Munji: Unable to authenticate with Facebook \(error)")
            } else if result?.isCancelled == true {
                print("Munji: User cancelled Facebook authentication")
                
            } else {
                print("Munji: Succesfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString) // for firebase
                firebaseAuth(credential)
                
            }
        }
        func firebaseAuth(_ credential: AuthCredential) {
            // authenticate with fire base then error handling
            Auth.auth().signIn(with: credential, completion: { (user, error ) in
                if error != nil {
                    print("Munji: Unable to authenticate with fire base - \(error)")
                } else {
                    print("Munji: Succesfully authenticated with Firebase")
                    if let user = user {
                        // we added the keychain wrapper here cause we are creating an account and the keychain is saved now here
                        self.completeSignIn(id: user.uid)
                    }
                    
                }
                
            })
            
        }
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            //firebase authentification
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                // means user existed and password is great, essentially no errors
                if error == nil {
                    print("Munji, email has been welcomed to the app")
                    if let user = user {
                        self.completeSignIn(id: user.user.uid)
                    }
                    // then lets create one
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        // if we come accross error then throw an error
                        if error != nil {
                            print("Munji: Failed to create an account w/ email")
                            // else the account was created
                        } else {
                            print("Munji: Succesfully created account w/ email")
                            if let user = user {
                                self.completeSignIn(id: user.user.uid)
                            }
                            
                        }
                    })
                }
            })
            
        }
    }
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Munji: Data saved to Keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)

    }
    
}

