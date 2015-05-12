//
//  LiplisChat.swift
//  Liplis
//
//  Created by sachin on 2015/04/26.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
struct LiplisChatJson {
    
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
    static func getChatTalkResponseRes(json:JSON)->MsgShortNews
    {
        return json2MsgShortNews(json)
    }
    
    
    /**
    ショートニュースのJSON変換取得
    */
    static func json2MsgShortNews(json:JSON)->MsgShortNews
    {
        var result : MsgShortNews = MsgShortNews()
        
        //タイトル取得
        if json["title"].string != nil
        {
            result.title = json["title"].string!
        }
        else
        {
            result.title = ""
        }
        
        //URL取得
        if json["url"].string != nil
        {
            result.url = json["url"].string!
        }
        else
        {
            result.url = ""
        }
        
        //alreadyフィールドが用意されているが不要のため無視
//        if json["already"].string != nil
//        {
//            json["already"].bool!
//        }
//        else
//        {
//            
//        }
        
        //内容取得
        if json["descriptionList"] != nil
        {
            for (idx:String,subJson:JSON) in json["descriptionList"]
            {
                //リザルト取得(コロン分割)
                var resList : Array<String> = split(subJson.description,{$0 == ";"})
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
                    }
                }
            }
        }
        else
        {
            result.nameList = []
            result.emotionList = []
            result.pointList = []
        }
        
        //読み込み完了
        result.flgSuccess = true
        
        return result
    }
}