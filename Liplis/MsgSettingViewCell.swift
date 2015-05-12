//
//  MsgSettingViewCell.swift
//  Liplis
//
//  Created by sachin on 2015/05/01.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
import UIKit
class MsgSettingViewCell {
    ///=============================
    /// プロパティ
    var title : String! = ""
    var content : String! = ""
    var partsType : Int! = 0          //0:タイトル 1:チェックボックス 2:スイッチ 3:ラジオボタン
    var settingIdx : Int! = 0         //設定インデックス　未設定時-1
    var initValue : Int!! = 0          //初期値
    var trueValue : Int! = 0          //設定が有効となるときの値
    var childList : Array<MsgSettingViewCell>! = []
    var hash : Int! = 0
    
    ///=============================
    /// レイアウトプロパティ
    var rowHeight : CGFloat! = 0      //高さ
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    init(title : String, content : String,partsType : Int, settingIdx : Int, initValue : Int, trueValue : Int,rowHeight : CGFloat)
    {
        self.title = title
        self.content = content
        self.partsType = partsType
        self.settingIdx = settingIdx
        self.initValue = initValue
        self.trueValue = trueValue
        self.rowHeight = rowHeight
        self.childList = []
    }
    
    
    func appendChild(child : MsgSettingViewCell)
    {
        childList.append(child)
        rowHeight = CGFloat((childList.count) * 45)
    }
    
}