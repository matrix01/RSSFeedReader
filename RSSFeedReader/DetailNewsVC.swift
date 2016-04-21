//
//  DetailNewsVC.swift
//  RSSFeedReader
//
//  Created by Milan Mia on 4/20/16.
//  Copyright © 2016 Milan Mia. All rights reserved.
//

import UIKit
import TwitterKit

class DetailNewsVC: UIViewController, TWTRComposerViewControllerDelegate {

    @IBOutlet weak var detailNewsView: UIWebView!
    internal var webLink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(webLink)
        UIWebView.loadRequest(detailNewsView)(NSURLRequest(URL: NSURL(string: webLink)!))
    }

    @IBAction func shareSocialMedia(sender: AnyObject) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Action Sheet", message: "Swiftly Now! Choose an option!", preferredStyle: .ActionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)
        let shareTwitter: UIAlertAction = UIAlertAction(title: "Share Twitter", style: .Default) { action -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            
            // Swift
            let composer = TWTRComposer()
            
            composer.setText(self.webLink)
            composer.setImage(UIImage(named: "fabric"))
            
            // Called from a UIViewController
            composer.showFromViewController(self) { result in
                if (result == TWTRComposerResult.Cancelled) {
                    print("Tweet composition cancelled")
                }
                else {
                    print("Sending tweet!")
                }
            }
            
            /*let store = Twitter.sharedInstance().sessionStore
            if let userid = store.session()?.userID {
                let client = TWTRAPIClient(userID: userid)
                let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/update.json"
                let params = ["status": "My First Tweet!", "url" : self.webLink]
                var clientError : NSError?
                
                let request = client.URLRequestWithMethod("POST", URL: statusesShowEndpoint, parameters: params, error: &clientError)
                client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                    if (connectionError == nil) {
                    }
                    else {
                        print("Error: \(connectionError)")
                    }
                }
            }*/
        }
        
        actionSheetController.addAction(shareTwitter)
        
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Share Facebook", style: .Default) { action -> Void in
        }
        actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
