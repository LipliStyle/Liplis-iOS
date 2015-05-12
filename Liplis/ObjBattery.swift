//
//  ObjBattery.swift
//  Liplis
//
//  Created by sachin on 2015/04/18.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
import UIKit

class ObjBattery
{
    ///=============================
    /// ステータス
    var batteryText : String!    = "";
    var batteryImage : String! = "";
    var batteryNowLevel : Float!	= 0;
    var batteryExists : Bool!	= false;
    
    ///=============================
    /// 定数
    let battery_100 : String! = "battery_100"
    let battery_87 : String! = "battery_87"
    let battery_75 : String! = "battery_75"
    let battery_62 : String! = "battery_62"
    let battery_50 : String! = "battery_50"
    let battery_37 : String! = "battery_37"
    let battery_25 : String! = "battery_25"
    let battery_12 : String! = "battery_12"
    let battery_0 : String! = "battery_0"
    let battery_non : String! = "battery_non"
    
    init()
    {
        batteryExists = false
        batteryText = ""
    }
    
    func getNon()->String
    {
        return battery_non
    }
    
    func getBatteryImage()
    {
        batteryCheck()
        
        if(batteryExists == true)
        {
            //
            if(batteryNowLevel <= 10)
            {
                batteryImage = battery_0;
            }else if(batteryNowLevel <= 12)
            {
                batteryImage = battery_12;
            }else if(batteryNowLevel <= 25)
            {
                batteryImage = battery_25;
            }else if(batteryNowLevel <= 37)
            {
                batteryImage = battery_37;
            }else if(batteryNowLevel <= 50)
            {
                batteryImage = battery_50;
            }else if(batteryNowLevel <= 62)
            {
                batteryImage = battery_62;
            }else if(batteryNowLevel <= 75)
            {
                batteryImage = battery_75;
            }else if(batteryNowLevel <= 87)
            {
                batteryImage = battery_87;
            }else if(batteryNowLevel > 87)
            {
                batteryImage = battery_100;
            }
            
            //バッテリー残量の表示
            batteryText = String(Int(batteryNowLevel)) + "%"
        }
        else
        {
            //バッテリー接続なし
            batteryText = "-";
        }
        
    }
    
    /// <summary>
    /// getBatteryRatel
    /// バッテリー割合を取得する
    /// </summary>
    func getBatteryRatel()->Int{
        batteryCheck()
        return Int(batteryNowLevel*100)
    }
    
    
    /// <summary>
    /// batteryCheck
    /// バッテリーチェック
    /// </summary>
    func batteryCheck()
    {
        //デバイスとバッテリー残量の宣言.
        let myDevice: UIDevice = UIDevice.currentDevice()
        
        //バッテリー状態の監視.
        myDevice.batteryMonitoringEnabled = true
    
        var myBatteryLevel = myDevice.batteryLevel
        var myBatteryState = myDevice.batteryState
        
        if myBatteryLevel != -1
        {
            batteryNowLevel 	= myBatteryLevel
            batteryExists 		= true
        }
        else
        {
            batteryNowLevel 	= 1
            batteryExists 		= false
        }
    }
    
    
}