//
//  LiplisShortNewsListJpJson.swift
//  Liplis
//
//  Created by kosuke on 2015/04/12.
//  Copyright (c) 2015年 sachin. All rights reserved.
//ResLpsChatResponse

import Foundation
struct LiplisShortNewsJpJson {
    
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
    //メッセージ生成
    //
    //============================================================
    
    
    /**
    ショートニュースリストの取得
    */
    static func getShortNews(json:JSON)->MsgShortNews
    {
        return json2MsgShortNews(json)
    }
    
    /**
        ショートニュースリストの取得
    */
    static func getShortNewsList(json:JSON)->Array<MsgShortNews>
    {
        return json2MsgShortNewsList(json)
    }
    
    /**
    ショートニュースのJSON変換取得
    */
    static func json2MsgShortNews(json:JSON)->MsgShortNews
    {
        var result : MsgShortNews = MsgShortNews()
        
        //URL取得
        if json["url"].string != nil
        {
            result.url = json["url"].string!
        }
        else
        {
            result.url = ""
        }
        
        if json["result"].string != nil
        {
            //リザルト取得(コロン分割)
            var resList : Array<String> = split(json["result"].string!,{$0 == ";"})
            var title : String = ""
            
            //リーフエモーション分割
            for leafAndEmotion : String in resList
            {
                //コンマ分割
                var leaf : Array<String> = split(leafAndEmotion,{$0 == ","})
                
                //リスト作成
                
                //配列チェック
                if leaf.count == 3
                {
                    if(leaf[0] == "EOS")
                    {
                        break
                    }
                    
                    result.nameList.append(leaf[0])
                    result.emotionList.append(leaf[1].toInt()!)
                    result.pointList.append(leaf[2].toInt()!)
                    
                    //タイトル作成
                    title = title + leaf[0]
                }
            }
            
            //作成したタイトルをメッセージにセット
            result.title = title
        }
        else
        {
            result.title = ""
            result.nameList = []
            result.emotionList = []
            result.pointList = []
        }
        
        //読み込み完了
        result.flgSuccess = true
        
        return result
    }
    
    /**
        ショートニュースリストのJSON変換取得
    */
    static func json2MsgShortNewsList(json:JSON)->Array<MsgShortNews>
    {
        var result :Array<MsgShortNews> = []

        //ニュースリストを回してメッセージリストに変換する
        for (idx:String,subJson:JSON) in json["lstNews"]
        {
            //メッセージ作成
            result.append(json2MsgShortNews(subJson))
        }
        
        return result
    }
    
    
    
    
    
    
}