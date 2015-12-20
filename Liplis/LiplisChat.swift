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
    internal static let KEY_OPLIST           : String = "opList"
    
    //============================================================
    //
    //メッセージ生成
    //
    //============================================================
    
    
    /**
    ショートニュースリストの取得
    */
    internal static func getChatTalkResponseRes(json:JSON)->ResLpsChatResponse
    {
        return json2MsgShortNews(json)
    }
    
    
    /**
    ショートニュースのJSON変換取得
    */
    internal static func json2MsgShortNews(json:JSON)->ResLpsChatResponse
    {
        let msg : MsgShortNews = MsgShortNews()
        let result : ResLpsChatResponse = ResLpsChatResponse()
        
        //タイトル取得
        if json[self.KEY_TITLE].string != nil
        {
            msg.title = json[self.KEY_TITLE].string!
        }
        else
        {
            msg.title = ""
        }
        
        //URL取得
        if json[self.KEY_URL].string != nil
        {
            msg.url = json[self.KEY_URL].string!
        }
        else
        {
            msg.url = ""
        }
        
        //オプション取得
        if json[self.KEY_OPLIST].array != nil
        {
            for (_, subJson): (String, JSON) in json[self.KEY_OPLIST]
            {
                result.opList.append(subJson.string!)
            }
            
            if result.opList.count == 2
            {
                result.context = result.opList[0]
                result.mode = result.opList[1]
            }
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
            for (_, subJson): (String, JSON) in json[self.KEY_DESCRIPTION_LIST]
            {
                //リザルト取得(コロン分割)
                let resList : Array<String> = subJson.description.characters.split(isSeparator : {$0 == ";"}).map { String($0) }
                
                //リーフエモーション分割
                for leafAndEmotion : String in resList
                {
                    //コンマ分割
                    var leaf : Array<String> = leafAndEmotion.characters.split(isSeparator : {$0 == ","}).map { String($0) }
                    
                    //リスト作成
                    
                    //配列チェック
                    if leaf.count == 3
                    {
                        if(leaf[0] == LiplisDefine.EOS)
                        {
                            break
                        }
                        
                        msg.nameList.append(leaf[0])
                        msg.emotionList.append(Int(leaf[1])!)
                        msg.pointList.append(Int(leaf[2])!)
                    }
                }
            }
        }
        else
        {
            msg.nameList = []
            msg.emotionList = []
            msg.pointList = []
        }
        
        //読み込み完了
        msg.flgSuccess = true
        
        //メッセージセット
        result.msg = msg
        
        return result
    }
}