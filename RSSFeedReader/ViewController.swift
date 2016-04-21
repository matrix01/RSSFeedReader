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

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                print("error: \(error!.localizedDescription)");
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

