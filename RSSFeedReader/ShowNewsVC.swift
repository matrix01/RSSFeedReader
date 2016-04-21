//
//  ShowNewsVC.swift
//  RSSFeedReader
//
//  Created by Milan Mia on 4/20/16.
//  Copyright © 2016 Milan Mia. All rights reserved.
//

import UIKit

class ShowNewsVC: UITableViewController {
    
    let newNewsFeed = newsFeed()
    internal var feedUrl: String = ""
    let newsImage: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(feedUrl)
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) { () -> Void in
            self.newNewsFeed.getNewsFeedWithUrl(self.feedUrl)
            dispatch_async(dispatch_get_main_queue(), {
                print(self.newNewsFeed.posts)
                self.tableView.reloadData()
                self.loadImage()
            })
        }
    }
    
    func loadImage() {
        for post in self.newNewsFeed.posts {
            let url = post.objectForKey("url") as! String
            if !url.isEmpty {
            let request = NSURLRequest(URL: NSURL(string: url)!)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { response, data, error in
                    if let imageData = data {
                        self.newsImage.addObject(UIImage(data: imageData)!)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData()
                        })
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newNewsFeed.posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("anotherCell", forIndexPath: indexPath)
        
        let titleLabel: UILabel = cell.viewWithTag(100) as! UILabel
        titleLabel.text = self.newNewsFeed.posts.objectAtIndex(indexPath.row).valueForKey("title") as? String
        
        let descriptionLabel: UILabel = cell.viewWithTag(101) as! UILabel
        descriptionLabel.text = self.newNewsFeed.posts.objectAtIndex(indexPath.row).valueForKey("description") as? String
        
        let dateLabel: UILabel = cell.viewWithTag(102) as! UILabel
        dateLabel.text = self.newNewsFeed.posts.objectAtIndex(indexPath.row).valueForKey("pubDate") as? String
        
        let newsImageView: UIImageView = cell.viewWithTag(105) as! UIImageView
        if newsImage.count > 0 && indexPath.row < newsImage.count {
            let imageForNews = newsImage.objectAtIndex(indexPath.row)
            newsImageView.image = imageForNews as! UIImage
        }
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let destination = storyboard.instantiateViewControllerWithIdentifier("detailNews") as! DetailNewsVC
        destination.webLink = (self.newNewsFeed.posts.objectAtIndex(indexPath.row).objectForKey("link") as? String)!
        
        navigationController?.pushViewController(destination, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
