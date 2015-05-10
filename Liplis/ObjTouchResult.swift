//
//  ObjTouchResult.swift
//  Liplis
//
//  Created by kosuke on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjTouchResult{
    ///=============================
    /// プロパティ
    var result : Int! = 0
    var obj : ObjTouch!
    
    init(result : Int, obj : ObjTouch)
    {
        self.result! = result
        self.obj! = obj
    }
    init(obj : ObjTouch!)
    {
        self.obj! = obj
    }
}