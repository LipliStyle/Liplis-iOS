//
//  LiplisUtil.swift
//  Liplis
//  リプリスユーティリティ
//
//  Created by kosuke on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
struct LiplisUtil {
    
    //============================================================
    //
    //乱数ユーティリティ
    // 
    //============================================================
    /**
        フロートの乱数を取得する
    */
    static func getRandormNumber(Min _Min : Float, Max _Max : Float)->Int
    {
        var resF : Float = ( Float(arc4random_uniform(UINT32_MAX)) / Float(UINT32_MAX) ) * (_Max - _Min) + _Min
        
        return Int(resF)
    }
    
    /**
        整数の乱数を取得する
    */
    static func getRandormNumber(Min _Min : Int, Max _Max : Int)->Int
    {
        var resF : Float = ( Float(arc4random_uniform(UINT32_MAX)) / Float(UINT32_MAX) ) * (Float(_Max) - Float(_Min)) + Float(_Min)
        
        return Int(resF)
    }
    
    //============================================================
    //
    //ランダム文字列ユーティリティ
    //
    //============================================================
    /**
    フロートの乱数を取得する
    */
    static func getRandormString(length : Int)->String
    {
        var sb : StringBuilder = StringBuilder()
        let alphabetList : Array<String> = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","x","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","X","X","Y","Z","1","2","3","4","5","6","7","8","9","0"]
        
        //指定数分、ランダムな文字列を作成する
        for i in 0...length
        {
            sb.append(alphabetList[getRandormNumber(Min: 0,Max: alphabetList.count - 1)])
        }
        
        //連結文字を返す
        return sb.toString()
    }
    
    
    //============================================================
    //
    //フラグ変換ユーティリティ
    //
    //============================================================
    /**
        ビットをイント(0.1)に変換する
    */
    static func bit2Int(bit : Bool)->Int
    {
        if(bit)
        {
            return 1
        }
        else
        {
            return 0
        }
    }
    
    /**
        イント(0.1)をビットに変換する
    */
    static func int2Bit(val : Int)->Bool
    {
        return val == 1
    }
    
    //============================================================
    //
    //アプリバージョン取得
    //
    //============================================================
    /**
    アプリバージョンを取得する
    */
    static func getAppVersion()->String
    {
        let version: AnyObject! = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")
        
        return String(version as NSString)
    }
    
    
}