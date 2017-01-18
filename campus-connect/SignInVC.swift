//
//  SignIn.swift
//  campus-connect
//
//  Created by Gabriel Meruvia on 1/18/17.
//  Copyright © 2017 Gabriel Meruvia. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyTextField!
    @IBOutlet weak var pwdField: FancyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    

    @IBAction func facebookBtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("GABO: Unable to authenticate with FACEBOOK")
            } else if result?.isCancelled == true {
                print("GABO: User cancelled FACEBOOK authentication")
            } else {
                print("GABO: Successfully authenticated with FACEBOOK ")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential: credential)
                
            }
        }
    }
    
    func firebaseAuth (credential : FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("GABO: Unable to authenticate with FIREBASE - \(error)")
            } else {
                print("GABO: Successfully authenticated with FIREBASE ")
                if let user = user{
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("GABO: Email user authenticated with Firebase.")
                    if let user = user{
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("GABO: Unable to authenticate with Firebase using email.")
                        } else{
                            print("GABO: Successfully authenticated with Firebase (email)")
                            if let user = user{
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn (id : String){
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("GABO: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)

        
    }

}
