//
//  LiplisChat.swift
//  Liplis
//
//  LiplisChatAPIの応答データ
//
//アップデート履歴
//   2015/04/26 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.3.0　リファクタリング
//
//  Created by sachin on 2015/04/26.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
struct LiplisChatJson {
    ///=============================
    ///XMLキー
    internal static let KEY_TITLE            : String = "title"
    internal static let KEY_URL              : String = "url"
    internal static let KEY_DESCRIPTION_LIST : String = "descriptionList"

    //============================================================
    //
    //メッセージ生成
    //
    //============================================================
    
    
    /**
    ショートニュースリストの取得
    */
    internal static func getChatTalkResponseRes(json:JSON)->MsgShortNews
    {
        return json2MsgShortNews(json)
    }
    
    
    /**
    ショートニュースのJSON変換取得
    */
    internal static func json2MsgShortNews(json:JSON)->MsgShortNews
    {
        var result : MsgShortNews = MsgShortNews()
        
        //タイトル取得
        if json[self.KEY_TITLE].string != nil
        {
            result.title = json[self.KEY_TITLE].string!
        }
        else
        {
            result.title = ""
        }
        
        //URL取得
        if json[self.KEY_URL].string != nil
        {
            result.url = json[self.KEY_URL].string!
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
        if json[self.KEY_DESCRIPTION_LIST] != nil
        {
            for (idx:String,subJson:JSON) in json[self.KEY_DESCRIPTION_LIST]
            {
                //リザルト取得(コロン分割)
                var resList : Array<String> = split(subJson.description,isSeparator : {$0 == ";"})
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