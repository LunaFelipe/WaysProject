//
//  FirebaseAuthManager.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 18/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import Foundation
import FirebaseAuth
import KeychainSwift
import Firebase
import FirebaseDatabase


class FirebaseAuthManager {

private var authUser : User? {
    return Auth.auth().currentUser
}

private var _keyChain = KeychainSwift()

var keyChain: KeychainSwift {
    get {
        return _keyChain
    } set {
        _keyChain = newValue
    }
}

func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
        if let user = authResult?.user {
            self.sendVerificationMail()
            completionBlock(true)
        } else {
            completionBlock(false)
        }
    }
}

//Sign In method is not here because the segue doesnt work
//    func signIn(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
//        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//            if error == nil && (user?.user.isEmailVerified)! {
//
//                self.completeSignIn(id: (user?.user.uid)!)
//                print("dsasasasa")
//
//                let storyboard = UIStoryboard(name: "MyStoryboardName", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "LogIn") as! LoginViewController
//                // Alternative way to present the new view controller
////                LoginViewController().showLogOut()
//                //perform segue here!!!!!
//                print("volteii")
//            } else {
//                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//                    if error != nil {
//                        print("cant sign in user")
//                    } else {
//                        self.completeSignIn(id: (user?.user.uid)!)
//                        LoginViewController().performSegue(withIdentifier: "login", sender: nil)
//                    }
//                }
//            }
//        }
//    }

func completeSignIn(id: String){
    keyChain.set(id, forKey: "uid")
}

public func sendVerificationMail() {
    if self.authUser != nil && !self.authUser!.isEmailVerified {
        self.authUser!.sendEmailVerification(completion: { (error) in
            // Notify the user that the mail has sent or couldn't because of an error.
        })
    }
    else {
        // Either the user is not available, or the user is already verified.
    }
}

func handleError(_ error: Error) -> UIAlertController{
    if let errorCode = AuthErrorCode(rawValue: error._code) {
        print(errorCode.errorMessage)
        let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    return UIAlertController()
}

}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
        default:
            return "Unknown error occurred"
        }
    }
}
