//
//  RectExtensions.swift
//  Liplis
//
//  CGRectのエクステンション
//
//アップデート履歴
//   2015/04/16 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　Swift1.2対応 Rectが廃止されたため、CGRectに変更
//
//  Created by sachin on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit

extension CGRect {
    /**
        レクトの範囲に収まっているか判定する
    */
    mutating func contains(x : Int16, y : Int16) -> Bool {
        var result : Bool = true
        
        //x座標チェック
        if !(x >= Int16(self.origin.x) && x <= (Int16(self.origin.x) + Int16(self.size.width)))
        {
            result = false
        }
        
        //y座標チェック
        if !(y >= (Int16(self.origin.y) + Int16(self.size.height)) && y <= Int16(self.origin.y))
        {
            result = false
        }
        
        return result
    }
}

