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
        var result : MsgShortNews = MsgShortNews()
        var nameValuePair : NameValuePair = NameValuePair()
        nameValuePair.add(BasicNameValuePair(key: "userid", value: uid))
        nameValuePair.add(BasicNameValuePair(key: "tone", value: toneUrl))
        nameValuePair.add(BasicNameValuePair(key: "version", value: version))
        nameValuePair.add(BasicNameValuePair(key: "sentence", value: sentence))
        nameValuePair.add(BasicNameValuePair(key: "context", value: self.context))
        
        return LiplisChatJson.getChatTalkResponseRes(LiplisApi.postJson(LiplisDefine.API_LIPLIS_CHAT, postData: nameValuePair.getPostData()))
    }
}