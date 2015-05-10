//
//  LiplisNews.swift
//  Liplis
//
//  Created by kosuke on 2015/04/11.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class LiplisNews {
    //=================================
    //プロパティ
    var newsQueue : Array<MsgShortNews>? = []
    var prvTime : Int = 0
    
    //=================================
    //定数
    let UPDATE_INTERVAL : Int = 60000       //連続実行防止のためのニュースのキュー取得待機インターバル
    let REFLESH_INTERVAL : Int = 1200000    //ニュースキューのリフレッシュ判定インターバル
    let LPS_NEWS_QUEUE_HOLD_CNT : Int = 25   //ニュースキューの最低保持件数
    let LPS_NEWS_QUEUE_GET_CNT : Int = 50   //ニュースキューの取得件数
    
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
        newsQueue = Array<MsgShortNews>()
        prvTime = 0
    }
    
    
    //============================================================
    //
    //ニュース取得処理
    //
    //============================================================
    /**
        ニュースを一件取得する
    */
    func getShortNews(postData : NSData!)->MsgShortNews!
    {
        var result : MsgShortNews = MsgShortNews()
        
        //キューチェック
        if(newsQueue?.count > 0)
        {
            //メッセージ出力
            println("LiplisNews getShortNews" + String(newsQueue!.count))
            
            //１件のデータを返す
            return newsQueue!.dequeue()
        }
        else
        {
            //メッセージ出力
            println("LiplisNews getShortNews キューが枯渇" + String(newsQueue!.count))
            
            //非同期処理実行
            AsyncGetNewsTask(postData)
            
            //単体データを返しておく
            return LiplisApi.getShortNews(postData)
            
        }
    }
    
    /**
        ニュースキューチェック
    */
    func checkNewsQueue(postData : NSData!)
    {
        if(newsQueue?.count < LPS_NEWS_QUEUE_HOLD_CNT)
        {
            if(Int(CFAbsoluteTimeGetCurrent())-prvTime > UPDATE_INTERVAL)
            {
                AsyncGetNewsTask(postData)
            }
        }
    }
    
    /**
        ニュースキューのカウントチェック
        キューに残量があればtrueを返す
    */
    func checkNewsQueueCount(postData : NSData!)->Bool
    {
        checkNewsQueue(postData)
        return newsQueue?.count > 0
    }
    
    //============================================================
    //
    //API呼び出し
    //
    //============================================================
    /**
    ニュースリスト取得する
    */
    func AsyncGetNewsTask(postData : NSData!)
    {
        var URL = NSURL(string: LiplisDefine.API_SHORT_NEWS_URL_LSIT)!
        var request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), callBackGetNewsList)

        //newsQueue?.addRange(LiplisApi.getShortNewsList(postData))
    }
    
    //============================================================
    //
    //レスポンスコールバック
    //
    //============================================================
    /**
    ニュースリスト取得のコールバック
    */
    func callBackGetNewsList(res: NSURLResponse!, data: NSData!, error: NSError!) {
        //UIの更新
        if error == nil {
            //取得したニュースデータをキューに入れる
            for newsData : MsgShortNews in LiplisShortNewsJpJson.getShortNewsList(JSON(data:data))
            {
                newsQueue?.enqueue(newsData)
            }
            
        } else {
            
        }
    }

}