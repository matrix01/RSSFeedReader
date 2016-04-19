//
//  ViewController.swift
//  RSSFeedReader
//
//  Created by Milan Mia on 4/19/16.
//  Copyright © 2016 Milan Mia. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let newNewsFeed = newsFeed()
        
        dispatch_async(queue) { () -> Void in
            newNewsFeed.getNewsFeedWithUrl("http://feeds.bbci.co.uk/news/rss.xml")
            dispatch_async(dispatch_get_main_queue(), {
                print("BBC Feed download finished!!")
                print(newNewsFeed.feeds)
            })
        }
        
        dispatch_async(queue) { () -> Void in
            newNewsFeed.getNewsFeedWithUrl("http://rss.cnn.com/rss/edition")
            dispatch_async(dispatch_get_main_queue(), {
                print("CNN Feed download finished!!")
                print(newNewsFeed.feeds)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

