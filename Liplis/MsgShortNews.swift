//
//  MsgShortNews.swift
//  Liplis
//
//  ニュースメッセージ
//  Liplisはこのフォーマットを使っておしゃべりする
//
//アップデート履歴
//   2015/04/11 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//
//  Created by sachin on 2015/04/11.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation

class MsgShortNews
{
    //=================================
    //プロパティ
    var nameList : Array<String> = []
    var emotionList : Array<Int> = []
    var pointList : Array<Int> = []
    var flgSuccess : Bool = false
    var url : String
    var title : String
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
        デフォルトイニシャライザ
    */
    init()
    {
        self.nameList = Array<String>()
        self.emotionList = Array<Int>()
        self.pointList = Array<Int>()
        self.flgSuccess = false
        self.url = ""
        self.title = ""
    }
    
    /**
        イニシャライザ
    */
    init(name:String,emotion:Int,point:Int)
    {
        self.nameList = Array<String>()
        self.emotionList = Array<Int>()
        self.pointList = Array<Int>()
        self.flgSuccess = false
        self.url = ""
        self.title = ""
        
        self.nameList.append(name)
        self.emotionList.append(emotion)
        self.pointList.append(point)
    }
    
    /**
        1個目のnameを返す
    */
    func getMessage() -> String
    {
        if(self.nameList.count > 0){
            return self.nameList[0]
        }
        else
        {
            return ""
        }
    }
    
    
    
    
    
}