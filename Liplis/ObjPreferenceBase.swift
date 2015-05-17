//
//  ObjPreferenceBase.swift
//  Liplis
//
//  設定のベースクラス
//
//アップデート履歴
//   2015/04/17 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0 リファクタリング
//
//  Created by sachin on 2015/04/17.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjPreferenceBase {
    /**
        設定の書き込み
    */
    internal func wirtePreference(key : String, value : String)
    {
        // 設定値の保存 キーは"keyName"、値は"value"としました。
        let config = NSUserDefaults.standardUserDefaults()
        config.setObject(value,forKey : key)
        config.synchronize()
    }
    
    /**
        設定の読み込み
    */
    internal func readPreference(key : String)->String
    {
        let config = NSUserDefaults.standardUserDefaults()
        let result : AnyObject! = config.objectForKey(key)
        
        if result != nil
        {
            return result as! NSString as String
        }
        else
        {
            return ""
        }
    }
    
    /**
        全設定の読み込み
    */
    internal func readAllPreference(key : String)->NSDictionary
    {
        let config = NSUserDefaults.standardUserDefaults()
        return config.dictionaryRepresentation()
    }
    
    /**
        設定の削除
    */
    internal func deletePreference(key : String)
    {
        let config = NSUserDefaults.standardUserDefaults()
        config.removeObjectForKey(key)
    }
    
    /**
    設定の取得
    */
    internal func getSetting(key : String, defaultValue : String)->String
    {
        var readStr = readPreference(key)
        
        if readStr != ""
        {
            return readStr
        }
        else
        {
            return defaultValue
        }
    }
    internal func getSettingInt(key : String, defaultValue : Int)->Int
    {
        var readStr = readPreference(key)
        
        if readStr != ""
        {
            return readStr.toInt()!
        }
        else
        {
            return defaultValue
        }
    }
    
    
    
    /**
        Liplis設定の書き込み
    */
    internal func setLiplisSetting(key : String,  value : String)
    {
        wirtePreference("setting_" + key, value: value)
    }
    internal func setLiplisSettingInt(key : String,  value : Int)
    {
        wirtePreference("setting_" + key, value: String(value))
    }
    
    /**
        Liplis設定の取得
    */
    internal func getLiplisSetting(key : String)->String
    {
        return readPreference("setting_" + key)
    }
    internal func getLiplisSettingInt(key : String)->Int
    {
        var readStr = readPreference("setting_" + key)
        
        if readStr != ""
        {
            return readStr.toInt()!
        }
        else
        {
            return 0
        }
    }
    
    /**
    JSONを取得する
    */
    internal func getJsonFromString(jsonStr : String)->JSON
    {
        var json : JSON = JSON(data:jsonStr.dataUsingEncoding(NSUTF8StringEncoding)!)
        return json
    }
    
    
    
    
    
}