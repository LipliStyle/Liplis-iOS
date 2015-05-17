//
//  ObjIcon.swift
//  Liplis
//
//  Liplisのアイコンインスタンス
//
//アップデート履歴
//   2015/05/04 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//
//  Created by sachin on 2015/05/04.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class ObjLiplisIcon {
    ///=============================
    /// プロパティ
    internal var imgSleep : UIImage!     //おやすみアイコン
    internal var imgWakeup : UIImage!    //起床アイコン
    internal var imgLog : UIImage!       //回想アイコン
    internal var imgSetting : UIImage!   //設定アイコン
    internal var imgIntro : UIImage!      //会話アイコン
    internal var imgBack : UIImage!      //時計背景アイコン
    internal var imgBattery_0 : UIImage!  //0%
    internal var imgBattery_12 : UIImage!  //12%
    internal var imgBattery_25 : UIImage!  //25%
    internal var imgBattery_37 : UIImage!  //37%
    internal var imgBattery_50 : UIImage!  //50%
    internal var imgBattery_62 : UIImage!  //62%
    internal var imgBattery_75 : UIImage!  //75%
    internal var imgBattery_87 : UIImage!  //87%
    internal var imgBattery_100 : UIImage! //100%
    internal var imgBattery_non : UIImage! //
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    /**
    デフォルトイニシャライザ
    */
    internal init()
    {
        self.imgSleep = UIImage(named: "ico_zzz")
        self.imgWakeup = UIImage(named: "ico_waikup")
        self.imgLog = UIImage(named: "ico_log")
        self.imgSetting = UIImage(named: "ico_setting")
        self.imgIntro = UIImage(named: "ico_intro")
        self.imgBack = UIImage(named: "ico_back")
        self.imgBattery_0 = UIImage(named: "battery_0")
        self.imgBattery_12 = UIImage(named: "battery_12")
        self.imgBattery_25 = UIImage(named: "battery_25")
        self.imgBattery_37 = UIImage(named: "battery_37")
        self.imgBattery_50 = UIImage(named: "battery_50")
        self.imgBattery_62 = UIImage(named: "battery_62")
        self.imgBattery_75 = UIImage(named: "battery_75")
        self.imgBattery_87 = UIImage(named: "battery_87")
        self.imgBattery_100 = UIImage(named: "battery_100")
        self.imgBattery_non = UIImage(named: "battery_non")
    }
    
    /**
    デフォルトイニシャライザ
    */
    internal init(windowPath : String)
    {
        self.imgSleep = UIImage(contentsOfFile: windowPath + "/ico_zzz.png")
        self.imgWakeup = UIImage(contentsOfFile: windowPath +  "/ico_waikup.png")
        self.imgLog = UIImage(contentsOfFile: windowPath + "/ico_log.png")
        self.imgSetting = UIImage(contentsOfFile: windowPath + "/ico_setting.png")
        self.imgIntro = UIImage(contentsOfFile: windowPath + "/ico_intro.png")
        self.imgBack = UIImage(contentsOfFile: windowPath + "/ico_back.png")
        self.imgBattery_0 = UIImage(contentsOfFile: windowPath + "/battery_0.png")
        self.imgBattery_12 = UIImage(contentsOfFile: windowPath + "/battery_12.png")
        self.imgBattery_25 = UIImage(contentsOfFile: windowPath + "/battery_25.png")
        self.imgBattery_37 = UIImage(contentsOfFile: windowPath + "/battery_37.png")
        self.imgBattery_50 = UIImage(contentsOfFile: windowPath + "/battery_50.png")
        self.imgBattery_62 = UIImage(contentsOfFile: windowPath + "/battery_62.png")
        self.imgBattery_75 = UIImage(contentsOfFile: windowPath + "/battery_75.png")
        self.imgBattery_87 = UIImage(contentsOfFile: windowPath + "/battery_87.png")
        self.imgBattery_100 = UIImage(contentsOfFile: windowPath + "/battery_100.png")
        self.imgBattery_non = UIImage(contentsOfFile: windowPath + "/battery_non.png")
        
        //互換性対策
        if self.imgIntro == nil{
            self.imgIntro = UIImage(contentsOfFile: windowPath + "/ico_thinking_not.png")
        }
    }
    
    //============================================================
    //
    //アイコン取得
    //
    //============================================================
    
    /**
    バッテリーアイコンを取得する
    */
    internal func getBatteryIcon(batteryNowLevel : Int)->UIImage!
    {
        //
        if(batteryNowLevel <= 10)
        {
            return self.imgBattery_0
        }else if(batteryNowLevel <= 12)
        {
            return self.imgBattery_12;
        }else if(batteryNowLevel <= 25)
        {
            return self.imgBattery_25;
        }else if(batteryNowLevel <= 37)
        {
            return self.imgBattery_37;
        }else if(batteryNowLevel <= 50)
        {
            return self.imgBattery_50
        }else if(batteryNowLevel <= 62)
        {
            return self.imgBattery_62
        }else if(batteryNowLevel <= 75)
        {
            return self.imgBattery_75
        }else if(batteryNowLevel <= 87)
        {
            return self.imgBattery_87
        }else if(batteryNowLevel > 87)
        {
            return self.imgBattery_100
        }
        else
        {
            return self.imgBattery_non
        }
    }
}