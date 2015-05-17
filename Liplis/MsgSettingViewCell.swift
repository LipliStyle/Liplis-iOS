//
//  MsgSettingViewCell.swift
//  Liplis
//
//  テーブルビューのセルのデータ
//
//アップデート履歴
//   2015/05/01 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//
//  Created by sachin on 2015/05/01.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
import UIKit
class MsgSettingViewCell {
    ///=============================
    /// プロパティ
    internal var title : String! = ""
    internal var content : String! = ""
    internal var partsType : Int! = 0          //0:タイトル 1:チェックボックス 2:スイッチ 3:ラジオボタン  LiplisDefineの設定部品定数参照
    internal var settingIdx : Int! = 0         //設定インデックス　未設定時-1
    internal var initValue : Int!! = 0          //初期値
    internal var trueValue : Int! = 0          //設定が有効となるときの値
    internal var childList : Array<MsgSettingViewCell>! = []
    internal var hash : Int! = 0
    
    ///=============================
    /// レイアウトプロパティ
    internal var rowHeight : CGFloat! = 0      //高さ
    
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
        self.childList.append(child)
        self.rowHeight = CGFloat((self.childList.count) * 45)
    }
    
}