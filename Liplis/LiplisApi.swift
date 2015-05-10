//
//  LiplisApi.swift
//  Liplis
//
//  Created by kosuke on 2015/04/11.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
struct LiplisApi
{
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    デフォルトイニシャライザ
    */
    init()
    {
        
    }
    
    //============================================================
    //
    //API
    //
    //============================================================
    /**
        ニュースを一件取得する
    */
    static func getShortNews(postData : NSData!)->MsgShortNews
    {
        return LiplisShortNewsJpJson.getShortNews(self.postJson(LiplisDefine.API_SHORT_NEWS_URL_NEW, postData: postData))
    }
    
    /**
        ニュースリストを一件取得する
    */
    static func getShortNewsList(postData : NSData!)->Array<MsgShortNews>
    {
        return LiplisShortNewsJpJson.getShortNewsList(self.postJson(LiplisDefine.API_SHORT_NEWS_URL_LSIT, postData: postData))
    }
    
    

    
    
    //============================================================
    //
    //通信処理
    //
    //============================================================
    
    /**
        HTTP通信(非同期)
        completionHandlerにはコールバック関数を指定する。
        (このクラスでは使用不可！！！！)
    */
//    static func post(url: String, cmpletionHandler handler: (NSURLResponse!, NSData!, NSError!) -> Void) {
//        
//        //HTTP通	信(1)
//        let URL = NSURL(string: url)!
//        let request = NSURLRequest(URL: URL)
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), cmpletionHandler handler)
//    }
    
    
    /**
        HTTP通信(同期)
        completionHandlerにはコールバック関数を指定する。
    */
    static func post(url: String,postData : NSData!)->NSString{
        let URL = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: URL, cachePolicy:NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        var result : NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        return self.data2str(result)
    }
    
    /**
        HTTP通信(同期)
        completionHandlerにはコールバック関数を指定する。
    */
    static func postData(url: String,postData : NSData!)->NSData{
        let URL = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: URL, cachePolicy:NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        var result : NSData! = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        return result
    }
    
    /**
        HTTP通信(同期JSON)
        completionHandlerにはコールバック関数を指定する。
    */
    static func postJson(url: String,postData : NSData!)->JSON{
        let URL = NSURL(string: url)!
        var request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        var result : NSData! = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if result != nil
        {
            print(data2str(result))
            return JSON(data:result)
        }
        else
        {
            return JSON("")
        }
    }
    
    
    /**
        NSDataをストリングに変換する
    */
    static func data2str(data: NSData?) -> NSString {
        return NSString(data: data!, encoding: NSUTF8StringEncoding)!
    }
    

}