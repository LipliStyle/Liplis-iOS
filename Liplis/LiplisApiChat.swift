//
//  LiplisApiChat.swift
//  Liplis
//
//  LiplisのチャットAPIにアクセスする
//
//アップデート履歴
//   2015/04/26 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/14 ver1.3.0　リファクタリング
//   2015/05/30 ver1.4.3　コンテキストが設定されていない問題修正
//
//  Created by sachin on 2015/04/26.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class LiplisApiChat
{
    ///=============================
    /// プロパティ
    internal var mode : String! = ""
    internal var context : String! = ""
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    internal init()
    {
        mode = ""
        context = ""
    }
    
    //============================================================
    //
    //送受信処理
    //
    //============================================================
    internal func apiPost(uid : String, toneUrl : String, version : String, sentence : String)->MsgShortNews
    {
        let nameValuePair : NameValuePair = NameValuePair()
        nameValuePair.add(BasicNameValuePair(key: "userid", value: uid))
        nameValuePair.add(BasicNameValuePair(key: "tone", value: toneUrl))
        nameValuePair.add(BasicNameValuePair(key: "version", value: version))
        nameValuePair.add(BasicNameValuePair(key: "sentence", value: sentence))
        nameValuePair.add(BasicNameValuePair(key: "context", value: self.context))
        
        let res : ResLpsChatResponse = LiplisChatJson.getChatTalkResponseRes(LiplisApi.postJson(LiplisDefine.API_LIPLIS_CHAT, postData: nameValuePair.getPostData()))
        
        self.context = res.context
        self.mode = res.mode
        
        return res.msg
    }
}