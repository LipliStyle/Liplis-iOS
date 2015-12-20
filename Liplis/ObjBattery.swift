//
//  ObjBattery.swift
//  Liplis
//
//  バッテリー管理クラス
//
//アップデート履歴
//   2015/04/18 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0 リファクタリング
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
    internal var batteryText : String!    = "";
    internal var batteryImage : String! = "";
    internal var batteryNowLevel : Float!	= 0;
    internal var batteryExists : Bool!	= false;
    
    ///=============================
    /// 定数
    internal let battery_100 : String! = "battery_100"
    internal let battery_87 : String! = "battery_87"
    internal let battery_75 : String! = "battery_75"
    internal let battery_62 : String! = "battery_62"
    internal let battery_50 : String! = "battery_50"
    internal let battery_37 : String! = "battery_37"
    internal let battery_25 : String! = "battery_25"
    internal let battery_12 : String! = "battery_12"
    internal let battery_0 : String! = "battery_0"
    internal let battery_non : String! = "battery_non"
    
    /**
    デフォルトコンストラクター
    */
    internal init()
    {
        self.batteryExists = false
        self.batteryText = ""
    }
    
    /**
    バッテリーなしアイコンの取得
    */
    internal func getNon()->String
    {
        return self.battery_non
    }
    
    /**
    バッテリーアイコンの取得
    */
    internal func getBatteryImage()
    {
        self.batteryCheck()
        
        if(self.batteryExists == true)
        {
            //
            if(self.batteryNowLevel <= 10)
            {
                self.batteryImage = self.battery_0;
            }else if(self.batteryNowLevel <= 12)
            {
                self.batteryImage = self.battery_12;
            }else if(self.batteryNowLevel <= 25)
            {
                self.batteryImage = self.battery_25;
            }else if(self.batteryNowLevel <= 37)
            {
                self.batteryImage = self.battery_37;
            }else if(self.batteryNowLevel <= 50)
            {
                self.batteryImage = self.battery_50;
            }else if(self.batteryNowLevel <= 62)
            {
                self.batteryImage = self.battery_62;
            }else if(self.batteryNowLevel <= 75)
            {
                self.batteryImage = self.battery_75;
            }else if(self.batteryNowLevel <= 87)
            {
                self.batteryImage = self.battery_87;
            }else if(self.batteryNowLevel > 87)
            {
                self.batteryImage = self.battery_100;
            }
            
            //バッテリー残量の表示
            self.batteryText = String(Int(self.batteryNowLevel)) + "%"
        }
        else
        {
            //バッテリー接続なし
            self.batteryText = "-";
        }
        
    }
    
    /**
    バッテリー割合を取得する
    */
    internal func getBatteryRatel()->Int{
        self.batteryCheck()
        return Int(self.batteryNowLevel*100)
    }
    
    /**
    バッテリーチェック
    */
    internal func batteryCheck()
    {
        //デバイスとバッテリー残量の宣言.
        let myDevice: UIDevice = UIDevice.currentDevice()
        
        //バッテリー状態の監視.
        myDevice.batteryMonitoringEnabled = true
    
        let myBatteryLevel = myDevice.batteryLevel
        //let myBatteryState = myDevice.batteryState
        
        if myBatteryLevel != -1
        {
            self.batteryNowLevel 	= myBatteryLevel
            self.batteryExists 		= true
        }
        else
        {
            self.batteryNowLevel 	= 1
            self.batteryExists 		= false
        }
    }
    
    
}