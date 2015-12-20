//
//  LiplisChatResponse.swift
//  Liplis
//
//  Created by sachin on 2015/05/30.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ResLpsChatResponse {
    //=================================
    //プロパティ
    internal var msg : MsgShortNews!
    internal var opList : Array<String>!
    internal var context : String!
    internal var mode : String!
    
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
        self.msg = MsgShortNews()
        self.opList = Array<String>()
        self.context = ""
        self.mode = ""
    }
}