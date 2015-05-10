//
//  ObjIcon.swift
//  Liplis
//
//  Created by kosuke on 2015/05/04.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class ObjLiplisIcon {
    ///=============================
    /// プロパティ
    var imgSleep : UIImage!     //おやすみアイコン
    var imgWakeup : UIImage!    //起床アイコン
    var imgLog : UIImage!       //回想アイコン
    var imgSetting : UIImage!   //設定アイコン
    var imgIntro : UIImage!      //会話アイコン
    var imgBack : UIImage!      //時計背景アイコン
    var imgBattery_0 : UIImage!  //0%
    var imgBattery_12 : UIImage!  //12%
    var imgBattery_25 : UIImage!  //25%
    var imgBattery_37 : UIImage!  //37%
    var imgBattery_50 : UIImage!  //50%
    var imgBattery_62 : UIImage!  //62%
    var imgBattery_75 : UIImage!  //75%
    var imgBattery_87 : UIImage!  //87%
    var imgBattery_100 : UIImage! //100%
    var imgBattery_non : UIImage! //
    
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
        imgSleep = UIImage(named: "ico_zzz")
        imgWakeup = UIImage(named: "ico_waikup")
        imgLog = UIImage(named: "ico_log")
        imgSetting = UIImage(named: "ico_setting")
        imgIntro = UIImage(named: "ico_intro")
        imgBack = UIImage(named: "ico_back")
        imgBattery_0 = UIImage(named: "battery_0")
        imgBattery_12 = UIImage(named: "battery_12")
        imgBattery_25 = UIImage(named: "battery_25")
        imgBattery_37 = UIImage(named: "battery_37")
        imgBattery_50 = UIImage(named: "battery_50")
        imgBattery_62 = UIImage(named: "battery_62")
        imgBattery_75 = UIImage(named: "battery_75")
        imgBattery_87 = UIImage(named: "battery_87")
        imgBattery_100 = UIImage(named: "battery_100")
        imgBattery_non = UIImage(named: "battery_non")
    }
    
    /**
    デフォルトイニシャライザ
    */
    init(windowPath : String)
    {
        imgSleep = UIImage(contentsOfFile: windowPath + "/ico_zzz.png")
        imgWakeup = UIImage(contentsOfFile: windowPath +  "/ico_waikup.png")
        imgLog = UIImage(contentsOfFile: windowPath + "/ico_log.png")
        imgSetting = UIImage(contentsOfFile: windowPath + "/ico_setting.png")
        imgIntro = UIImage(contentsOfFile: windowPath + "/ico_intro.png")
        imgBack = UIImage(contentsOfFile: windowPath + "/ico_back.png")
        imgBattery_0 = UIImage(contentsOfFile: windowPath + "/battery_0.png")
        imgBattery_12 = UIImage(contentsOfFile: windowPath + "/battery_12.png")
        imgBattery_25 = UIImage(contentsOfFile: windowPath + "/battery_25.png")
        imgBattery_37 = UIImage(contentsOfFile: windowPath + "/battery_37.png")
        imgBattery_50 = UIImage(contentsOfFile: windowPath + "/battery_50.png")
        imgBattery_62 = UIImage(contentsOfFile: windowPath + "/battery_62.png")
        imgBattery_75 = UIImage(contentsOfFile: windowPath + "/battery_75.png")
        imgBattery_87 = UIImage(contentsOfFile: windowPath + "/battery_87.png")
        imgBattery_100 = UIImage(contentsOfFile: windowPath + "/battery_100.png")
        imgBattery_non = UIImage(contentsOfFile: windowPath + "/battery_non.png")
        
        //互換性対策
        if imgIntro == nil{
            imgIntro = UIImage(contentsOfFile: windowPath + "/ico_thinking_not.png")
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
    func getBatteryIcon(batteryNowLevel : Int)->UIImage!
    {
        //
        if(batteryNowLevel <= 10)
        {
            return imgBattery_0
        }else if(batteryNowLevel <= 12)
        {
            return imgBattery_12;
        }else if(batteryNowLevel <= 25)
        {
            return imgBattery_25;
        }else if(batteryNowLevel <= 37)
        {
            return imgBattery_37;
        }else if(batteryNowLevel <= 50)
        {
            return imgBattery_50
        }else if(batteryNowLevel <= 62)
        {
            return imgBattery_62
        }else if(batteryNowLevel <= 75)
        {
            return imgBattery_75
        }else if(batteryNowLevel <= 87)
        {
            return imgBattery_87
        }else if(batteryNowLevel > 87)
        {
            return imgBattery_100
        }
        else
        {
            return imgBattery_non
        }
        
    }
}