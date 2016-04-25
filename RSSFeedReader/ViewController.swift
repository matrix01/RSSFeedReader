//
//  ViewController.swift
//  RSSFeedReader
//
//  Created by Milan Mia on 4/19/16.
//  Copyright © 2016 Milan Mia. All rights reserved.
//

import UIKit
import TwitterKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController, GPPSignInDelegate{
    
    var kClientId = "215512503689-prmdp2ocmivar9moo90kghie94f18bp5.apps.googleusercontent.com";
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the sign in object.
        let signIn = GPPSignIn.sharedInstance()
        signIn.shouldFetchGooglePlusUser = true
        signIn.clientID = kClientId;
        signIn.shouldFetchGoogleUserEmail = true
        signIn.shouldFetchGoogleUserID = true;
        signIn.scopes = [kGTLAuthScopePlusLogin]
        signIn.delegate = nil
        signIn.trySilentAuthentication()
    }

    @IBAction func twitterLoginButton(sender: AnyObject) {
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if (session != nil) {
                self.performSegueWithIdentifier("changeListVC", sender: nil)
            } else {
                print("error: \(error!.localizedDescription)");
            }
        }
    }
    
    @IBAction func facebookLoginButton(sender: AnyObject) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self, handler: { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions.contains("email")) {
                    self.performSegueWithIdentifier("changeListVC", sender: nil)
                }
            } else {
                print("error: \(error!.localizedDescription)")
            }
        })
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        if(error == nil){
            self.performSegueWithIdentifier("changeListVC", sender: nil)
        }else {
            print("error: \(error!.localizedDescription)")
        }
    }
    
    func didDisconnectWithError(error: NSError!) {
        print(error)
    }
    
    @IBAction func googleLoginButton(sender: AnyObject) {
        let signIn = GPPSignIn.sharedInstance()
        signIn.delegate = self
        signIn.authenticate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

