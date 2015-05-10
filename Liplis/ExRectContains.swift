//
//  RectExtensions.swift
//  Liplis
//
//  Created by kosuke on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
extension Rect {
    /**
        レクトの範囲に収まっているか判定する
    */
    mutating func contains(x : Int16, y : Int16) -> Bool {
        var result : Bool = true
        
        //x座標チェック
        if !(x >= self.left && x <= self.right)
        {
            result = false
        }
        
        //y座標チェック
        if !(y >= self.bottom && y <= self.top)
        {
            result = false
        }
        
        return result
    }
}

