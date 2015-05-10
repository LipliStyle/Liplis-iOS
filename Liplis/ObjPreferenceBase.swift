//
//  ObjPreferenceBase.swift
//  Liplis
//  設定のベースクラス
//
//  Created by kosuke on 2015/04/17.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjPreferenceBase {
    /**
        設定の書き込み
    */
    func wirtePreference(key : String, value : String)
    {
        // 設定値の保存 キーは"keyName"、値は"value"としました。
        let config = NSUserDefaults.standardUserDefaults()
        config.setObject(value,forKey : key)
        config.synchronize()
    }
    
    /**
        設定の読み込み
    */
    func readPreference(key : String)->String
    {
        let config = NSUserDefaults.standardUserDefaults()
        let result : AnyObject! = config.objectForKey(key)
        
        if result != nil
        {
            return result as NSString
        }
        else
        {
            return ""
        }
    }
    
    /**
        全設定の読み込み
    */
    func readAllPreference(key : String)->NSDictionary
    {
        let config = NSUserDefaults.standardUserDefaults()
        return config.dictionaryRepresentation()
    }
    
    /**
        設定の削除
    */
    func deletePreference(key : String)
    {
        let config = NSUserDefaults.standardUserDefaults()
        config.removeObjectForKey(key)
    }
    
    /**
    設定の取得
    */
    func getSetting(key : String, defaultValue : String)->String
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
    func getSettingInt(key : String, defaultValue : Int)->Int
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
    func setLiplisSetting(key : String,  value : String)
    {
        wirtePreference("setting_" + key, value: value)
    }
    func setLiplisSettingInt(key : String,  value : Int)
    {
        wirtePreference("setting_" + key, value: String(value))
    }
    
    /**
        Liplis設定の取得
    */
    func getLiplisSetting(key : String)->String
    {
        return readPreference("setting_" + key)
    }
    func getLiplisSettingInt(key : String)->Int
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
    func getJsonFromString(jsonStr : String)->JSON
    {
        var json : JSON = JSON(data:jsonStr.dataUsingEncoding(NSUTF8StringEncoding)!)
        return json
    }
    
    
    
    
    
}