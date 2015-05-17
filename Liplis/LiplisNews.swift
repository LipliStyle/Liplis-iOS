//
//  LiplisNews.swift
//  Liplis
//
//  Liplisのニュースを取得、管理するクラス
//
//アップデート履歴
//   2015/04/11 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/14 ver1.3.0　リファクタリング
//
//  Created by sachin on 2015/04/11.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class LiplisNews {
    //=================================
    //プロパティ
    internal var newsQueue : Array<MsgShortNews>? = []
    internal var prvTime : Int = 0
    
    //=================================
    //定数
    private let UPDATE_INTERVAL : Int = 60000       //連続実行防止のためのニュースのキュー取得待機インターバル
    private let REFLESH_INTERVAL : Int = 1200000    //ニュースキューのリフレッシュ判定インターバル
    private let LPS_NEWS_QUEUE_HOLD_CNT : Int = 25   //ニュースキューの最低保持件数
    private let LPS_NEWS_QUEUE_GET_CNT : Int = 50   //ニュースキューの取得件数
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    デフォルトイニシャライザ
    */
    internal init()
    {
        self.newsQueue = Array<MsgShortNews>()
        self.prvTime = 0
    }
    
    
    //============================================================
    //
    //ニュース取得処理
    //
    //============================================================
    /**
        ニュースを一件取得する
    */
    internal func getShortNews(postData : NSData!)->MsgShortNews!
    {
        var result : MsgShortNews = MsgShortNews()
        
        //キューチェック
        if(self.newsQueue?.count > 0)
        {
            //メッセージ出力
            println("LiplisNews getShortNews" + String(self.newsQueue!.count))
            
            //１件のデータを返す
            return self.newsQueue!.dequeue()
        }
        else
        {
            //メッセージ出力
            println("LiplisNews getShortNews キューが枯渇" + String(self.newsQueue!.count))
            
            //非同期処理実行
            AsyncGetNewsTask(postData)
            
            //単体データを返しておく
            return LiplisApi.getShortNews(postData)
            
        }
    }
    
    /**
        ニュースキューチェック
    */
    internal func checkNewsQueue(postData : NSData!)
    {
        if(self.newsQueue?.count < LPS_NEWS_QUEUE_HOLD_CNT)
        {
            if(Int(CFAbsoluteTimeGetCurrent()) - self.prvTime > UPDATE_INTERVAL)
            {
                AsyncGetNewsTask(postData)
            }
        }
    }
    
    /**
        ニュースキューのカウントチェック
        キューに残量があればtrueを返す
    */
    internal func checkNewsQueueCount(postData : NSData!)->Bool
    {
        self.checkNewsQueue(postData)
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
    internal func AsyncGetNewsTask(postData : NSData!)
    {
        var URL = NSURL(string: LiplisDefine.API_SHORT_NEWS_URL_LSIT)!
        var request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: callBackGetNewsList)
    }
    
    //============================================================
    //
    //レスポンスコールバック
    //
    //============================================================
    /**
    ニュースリスト取得のコールバック
    */
    internal func callBackGetNewsList(res: NSURLResponse!, data: NSData!, error: NSError!) {
        //UIの更新
        if error == nil {
            //取得したニュースデータをキューに入れる
            for newsData : MsgShortNews in LiplisShortNewsJpJson.getShortNewsList(JSON(data:data))
            {
                self.newsQueue?.enqueue(newsData)
            }
            
        } else {
            
        }
    }

}