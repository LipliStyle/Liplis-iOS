//
//  LiplisApiChat.swift
//  Liplis
//
//  Created by kosuke on 2015/04/26.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class LiplisApiChat
{
    ///=============================
    /// プロパティ
    var mode : String! = ""
    var context : String! = ""
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    init()
    {
        mode = ""
        context = ""
    }
    
    //============================================================
    //
    //送受信処理
    //
    //============================================================
    func apiPost(uid : String, toneUrl : String, version : String, sentence : String)->MsgShortNews
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