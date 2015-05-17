//
//  ObjTouchResult.swift
//  Liplis
//
//  タッチ結果オブジェクト
//
//アップデート履歴
//   2015/04/16 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//
//  Created by sachin on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjTouchResult{
    ///=============================
    /// プロパティ
    internal var result : Int! = 0
    internal var obj : ObjTouch!
    
    internal init(result : Int, obj : ObjTouch)
    {
        self.result! = result
        self.obj! = obj
    }
    internal init(obj : ObjTouch!)
    {
        self.obj! = obj
    }
}