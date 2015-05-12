//
//  ObjLiplisLog.swift
//  Liplis
//
//  Created by sachin on 2015/04/17.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjLiplisLog {
    ///=============================
    /// プロパティ
    var log : String! = ""
    var url : String! = ""
    var type : Int! = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    init(log : String!, url : String!,type : Int! )
    {
        self.log = log
        self.url = url
        self.type = type
    }
    
    
    
}