//
//  DetailNewsVC.swift
//  RSSFeedReader
//
//  Created by Milan Mia on 4/20/16.
//  Copyright © 2016 Milan Mia. All rights reserved.
//

import UIKit
import TwitterKit
import FBSDKShareKit
import FBSDKCoreKit
import FBSDKLoginKit

class DetailNewsVC: UIViewController, FBSDKSharingDelegate, TWTRComposerViewControllerDelegate {

    @IBOutlet weak var detailNewsView: UIWebView!
    internal var webLink: String = ""
    internal var contentTitle: String = ""
    internal var contentDesc: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIWebView.loadRequest(detailNewsView)(NSURLRequest(URL: NSURL(string: webLink)!))
    }

    @IBAction func shareSocialMedia(sender: AnyObject) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Action Sheet", message: "Share news! Choose an option!", preferredStyle: .ActionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)
        let shareTwitter: UIAlertAction = UIAlertAction(title: "Share Twitter", style: .Default) { action -> Void in
            
            let composer = TWTRComposer()
            composer.setText(self.webLink)
            composer.setImage(UIImage(named: "fabric"))
            
            composer.showFromViewController(self) { result in
                if (result == TWTRComposerResult.Cancelled) {
                    print("Tweet composition cancelled")
                }
                else {
                    print("Sending tweet!")
                }
            }
        }
        
        actionSheetController.addAction(shareTwitter)
        
        let shareFacebook: UIAlertAction = UIAlertAction(title: "Share Facebook", style: .Default) { action -> Void in
            let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
            content.contentURL = NSURL(string: self.webLink)
            content.contentTitle = self.contentTitle
            content.contentDescription = self.contentDesc
            
            let shareDialog: FBSDKShareDialog = FBSDKShareDialog()
            shareDialog.shareContent = content
            shareDialog.delegate = self
            shareDialog.fromViewController = self
            shareDialog.show()
        }
        actionSheetController.addAction(shareFacebook)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject: AnyObject]) {
        print(results)
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("sharer NSError")
        print(error.description)
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("sharerDidCancel")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
