//
//  DataServices.swift
//  SocialMedia
//
//  Created by Munji on 7/26/18.
//  Copyright © 2018 Munji. All rights reserved.
//

import Foundation
import Firebase

// this is a global variable representing our heirachy HTTPS link in Firebase. In GoogleSerivice.plist this gives us the ability to automatticaly acces our data instead of using the link found in Firebase data. It's the foundation 
let DB_BASE = Database.database().reference()

class DataServices {
    
    static let ds = DataServices()
    private var _REF_BASE = DB_BASE
    private var _REF_POST = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    // Security reasons so that no one else can reference these
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POST: DatabaseReference {
        return _REF_POST
    }
    
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary< String, String> ) {
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
    
}
