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
    var mediaThumbnailInt : Int = Int()
    
    var NewsFeedicon : [String] = []
    var NewsFeedtitle : [String] = []
    var NewsFeedurl : [String] = []
    var NewsFeedrss : [String] = []
    var NewsFeedobjects : [String] = []
    
    var FeedName : NSString = NSString()
    var FeedIcon : NSString = NSString()
    
    var newsNumber : Int = Int()
    var newsName : NSString = NSString()
    var newsRSSLink : NSString = NSString()
    var mediaData : NSString = NSString()
    var colorData : NSString = NSString()
    
    var NewsURL : NSURL = NSURL()
    
    var parseR : NSXMLParser = NSXMLParser()
    var feeds : NSMutableArray = NSMutableArray()
    
    var itemr : NSMutableDictionary = NSMutableDictionary()
    var TitleR : NSMutableString = NSMutableString()
    var descriptionR : NSMutableString = NSMutableString()
    var imageR : NSMutableString = NSMutableString()
    var media : NSMutableString = NSMutableString()
    var date : NSMutableString = NSMutableString()
    var Link : NSMutableString = NSMutableString()
    var element : NSString = NSString()
    var attribues : NSDictionary = NSDictionary()
    
    internal func getNewsFeedWithUrl(feedUrl:String) {
        NewsURL = NSURL(string: feedUrl)!
        parseR = NSXMLParser(contentsOfURL: NewsURL)!
        
        FeedName = "BBC News: Top Stories"
        FeedIcon = "BBCtile.png"
        
        parseR.delegate = self
        parseR.shouldResolveExternalEntities = true
        parseR.shouldProcessNamespaces = true
        parseR.shouldReportNamespacePrefixes = true
        parseR.shouldResolveExternalEntities = true
        parseR.parse()
        //self.navigationItem.title = FeedName
        mediaData = "media:thumbnail width= 144"
    }
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, attributes attributeDict: NSDictionary!){
        element = elementName
        attribues = attributeDict
        if element.isEqualToString("item"){
            itemr = NSMutableDictionary()
            TitleR = NSMutableString()
            descriptionR = NSMutableString()
            date = NSMutableString()
            imageR = NSMutableString()
            media = NSMutableString()
            Link = NSMutableString()
        }
    }
    
    func parser(parser: NSXMLParser, foundCDATA CDATABlock: NSData){
        let dataString = String(data: CDATABlock, encoding: NSUTF8StringEncoding)
        if element .isEqualToString("description"){
            descriptionR.appendString(dataString!)
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String){
        if element.isEqualToString("title"){
            TitleR.appendString(string)
        }
        else if element.isEqualToString("description"){
            descriptionR.appendString(string)
        }
        else if element.isEqualToString("pubDate"){
            date.appendString(string)
        }
        else if element.isEqualToString("image"){
            imageR.appendString(string)
        }
        else if element.isEqualToString("media:thumbnail"){
            media.appendString(attribues.objectForKey("url") as! String)
        }
        else if element.isEqualToString("link"){
            Link.appendString(string)
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        element = elementName
        
        if element.isEqualToString("item"){
            
            itemr.setObject(TitleR, forKey: "title")
            itemr.setObject(descriptionR, forKey: "description")
            itemr.setObject(date, forKey: "pubDate")
            itemr.setObject(media, forKey: "media:thumbnail")
            itemr.setObject(Link, forKey: "link")
            feeds.addObject(itemr.copy())
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser){
        //print(feeds);
    }
}