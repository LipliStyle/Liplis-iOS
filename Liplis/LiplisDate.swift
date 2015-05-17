//
//  LiplisDate.swift
//  Liplis
//
//  日付を取得するクラス
//
//アップデート履歴
//   2015/05/05 ver0.1.0 作成
//   2015/05/16 ver1.4.0　カレンダーの表記をSwift1.2対応
//
//  Created by sachin on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class LiplisDate {
    ///=============================
    /// バージョン 追加
    var year : Int?     //年
    var month : Int?    //月
    var day : Int?      //日
    var hour : Int?     //時間
    var minute : Int?   //分
    var second : Int?   //秒
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
        イニシャライザ
        任意の時刻設定
    */
    init(year : Int, month : Int, day : Int, hour : Int, minute : Int, second : Int)
    {
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    /**
        デフォルトイニシャライザ
    */
    init()
    {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        var comps:NSDateComponents = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond,fromDate: date)
        
        self.year = comps.year
        self.month = comps.month
        self.day = comps.day
        self.hour = comps.hour
        self.minute = comps.minute
        self.second = comps.second
    }
    
    //============================================================
    //
    //日付取得処理
    //
    //============================================================
    /**
        普通の日付フォーマットのストリングを返す
    */
    func getNormalFormatDate()->String
    {
        var result : String! = ""
        result = String(self.year!) + "/"
        result = result + String(self.month!) + "/"
        result = result + String(self.day!) + " "
        
        result = result + String(self.hour!) + " "
        result = result + String(self.minute!) + " "
        result = result + String(self.second!)
        
        return result
    }
    
    func getTimeStr()->String
    {
        var result : String! = ""
        result = String(self.year!)
        result = result + String(self.month!)
        result = result + String(self.day!)
        
        result = result + String(self.hour!)
        result = result + String(self.minute!)
        result = result + String(self.second!)
        return result
    }
    
}