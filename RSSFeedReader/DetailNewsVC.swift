//
//  DetailNewsVC.swift
//  RSSFeedReader
//
//  Created by Milan Mia on 4/20/16.
//  Copyright © 2016 Milan Mia. All rights reserved.
//

import UIKit

class DetailNewsVC: UIViewController {

    @IBOutlet weak var detailNewsView: UIWebView!
    internal var webLink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(webLink)
        UIWebView.loadRequest(detailNewsView)(NSURLRequest(URL: NSURL(string: "http://www.bbc.co.uk/news/uk-36086291")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
