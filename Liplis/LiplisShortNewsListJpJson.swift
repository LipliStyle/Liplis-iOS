//
//  LiplisShortNewsListJpJson.swift
//  Liplis
//
//  LiplisShortNewsListAPIの応答データ
//
//アップデート履歴
//   2015/04/12 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　リファクタリング
//
//  Created by sachin on 2015/04/12.
//  Copyright (c) 2015年 sachin. All rights reserved.
//ResLpsChatResponse

import Foundation
struct LiplisShortNewsJpJson {
    ///=============================
    ///XMLキー
    internal static let KEY_RESULT           : String = "result"
    internal static let KEY_URL              : String = "url"
    internal static let KEY_LSTNEWS          : String = "lstNews"

    //============================================================
    //
    //メッセージ生成
    //
    //============================================================
    
    
    /**
    ショートニュースリストの取得
    */
    internal static func getShortNews(json:JSON)->MsgShortNews
    {
        return json2MsgShortNews(json)
    }
    
    /**
        ショートニュースリストの取得
    */
    internal static func getShortNewsList(json:JSON)->Array<MsgShortNews>
    {
        return json2MsgShortNewsList(json)
    }
    
    /**
    ショートニュースのJSON変換取得
    */
    internal static func json2MsgShortNews(json:JSON)->MsgShortNews
    {
        var result : MsgShortNews = MsgShortNews()
        
        //URL取得
        if json[self.KEY_URL].string != nil
        {
            result.url = json[self.KEY_URL].string!
        }
        else
        {
            result.url = ""
        }
        
        if json[self.KEY_RESULT].string != nil
        {
            //リザルト取得(コロン分割)
            var resList : Array<String> = split(json[self.KEY_RESULT].string!,isSeparator : {$0 == ";"})
            var title : String = ""
            
            //リーフエモーション分割
            for leafAndEmotion : String in resList
            {
                //コンマ分割
                var leaf : Array<String> = split(leafAndEmotion,isSeparator : {$0 == ","})
                
                //リスト作成
                
                //配列チェック
                if leaf.count == 3
                {
                    if(leaf[0] == LiplisDefine.EOS)
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
    internal static func json2MsgShortNewsList(json:JSON)->Array<MsgShortNews>
    {
        var result :Array<MsgShortNews> = []

        //ニュースリストを回してメッセージリストに変換する
        for (idx:String,subJson:JSON) in json[self.KEY_LSTNEWS]
        {
            //メッセージ作成
            result.append(json2MsgShortNews(subJson))
        }
        
        return result
    }
}