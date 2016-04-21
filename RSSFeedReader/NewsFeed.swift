//
//  BBCNewsFeed.swift
//  RSSFeedReader
//
//  Created by Milan Mia on 4/19/16.
//  Copyright © 2016 Milan Mia. All rights reserved.
//

import Foundation
import UIKit

class newsFeed:NSObject, NSXMLParserDelegate{
    
    var parser = NSXMLParser()
    internal var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var link = NSMutableString()
    var url = NSMutableString()
    var newsDescription = NSMutableString()
    var attribues : NSDictionary = NSDictionary()
    var urlFlag : Bool = Bool()
    var isCNN : Bool = Bool()
    
    internal func getNewsFeedWithUrl(feedUrl:String) {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:feedUrl))!)!
        parser.delegate = self
        parser.parse()
        urlFlag = true
    }
    
    
    //MARK: -XML Parser Delegate
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        element = elementName
        attribues = attributeDict
        if (elementName as NSString).isEqualToString("item"){
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            newsDescription = NSMutableString()
            attribues = NSMutableDictionary()
            link = NSMutableString()
            url = NSMutableString()
            urlFlag = true
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String){
        if element.isEqualToString("title") {
            title1.appendString(string)
        } else if element.isEqualToString("description") {
            newsDescription.appendString(string)
        } else if element.isEqualToString("media:thumbnail") && urlFlag == true {
            url.appendString(attribues.objectForKey("url") as! String)
            urlFlag = false
        }
        else if element.isEqualToString("link"){
            link.appendString(string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))
        } else if element.isEqualToString("pubDate"){
            date.appendString(string)
        }
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if (elementName as NSString).isEqualToString("item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
            }
            if !newsDescription.isEqual(nil) {
                elements.setObject(newsDescription, forKey: "description")
            }
            if !link.isEqual(nil) {
                elements.setObject(url, forKey: "url")
            }
            if !date.isEqual(nil) {
                elements.setObject(link, forKey: "link")
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "pubDate")
            }
            posts.addObject(elements)
        }
    }
}