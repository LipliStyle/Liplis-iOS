//
//  ObjLiplisLog.swift
//  Liplis
//
//  ログ1件データ
//
//アップデート履歴
//   2015/04/17 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//
//  Created by sachin on 2015/04/17.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjLiplisLog {
    ///=============================
    /// プロパティ
    internal var log : String! = ""
    internal var url : String! = ""
    internal var type : Int! = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    internal init(log : String!, url : String!,type : Int! )
    {
        self.log = log
        self.url = url
        self.type = type
    }
    
    
    
}