//
//  JsonListManager.swift
//  Liplis
//
//  Created by sachin on 2015/04/27.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
//格納JSON
// {"keylist":["key1","key2","key3"]}

import Foundation
class LiplisKeyManager : ObjPreferenceBase
{
    ///=============================
    /// キーリスト
    var keyList : Array<String> = []
    
    ///=============================
    /// 書き込みキー
    let JSON_KEY = "keylist"
    
    /**
    コンストラクター
    */
    override init()
    {
        //親の初期化
        super.init()
        
        //復活させる
        getKeyList()
    }
    
    /**
    キーを追加する
    */
    func addKey(key : String)
    {
        var flgHit : Bool = false
        
        //キーの存在チェック
        for str in keyList
        {
            if str == key
            {
                flgHit = true
            }
        }
        
        //該当キーがなければ追加する
        if !flgHit
        {
            keyList.append(key)
            saveKeyList()
        }

    }
    
    /**
    キーを削除する
    */
    func delKey(pKey : String)
    {
        var idx : Int = 0
        
        for key in keyList
        {
            if(key == pKey)
            {
                keyList.removeAtIndex(idx)
                saveKeyList()
                return
            }
            
            idx++
        }
    }
    
    /**
    キーを削除する
    */
    func delAllKey()
    {
        keyList.removeAll(keepCapacity: false)
        saveKeyList()
    }
    
    /**
    キーリストを保存する
    */
    func saveKeyList()
    {
        var jsonStr : StringBuilder = StringBuilder()
        
        //開始かっこ
        jsonStr.append("{\"")
        jsonStr.append(JSON_KEY)
        jsonStr.append("\":[")
        
        if keyList.count >= 2
        {
            //最後の1個以外全部入れる
            for idx in 0...keyList.count-2
            {
                jsonStr.append("\"" + keyList[idx] + "\",")
            }
            
            //最後の1個を入れる
            jsonStr.append("\"" + keyList[keyList.count-1] + "\"")
        }
        else if keyList.count == 1
        {
            //要素が1個の場合
            jsonStr.append("\"" + keyList[0] + "\"")
        }
        else
        {
            //要素0の場合何もしない
        }
        
        //とじかっこ
        jsonStr.append("]}")
        
        //JSONを保存する
        wirtePreference(JSON_KEY, value: jsonStr.toString())
    }
    
    /**
    キーリストをプリファレンスから復元し、取得する
    */
    func getKeyList()
    {
        //キーリストの初期化
        keyList = []
        
        //キーリストの取得
        var json : JSON = getJsonFromString(getSetting(JSON_KEY, defaultValue: ""))
        
        print(json[JSON_KEY] )
        
        //ヌルチェック
        if json[JSON_KEY] != nil
        {
            //回して復元
            for (idx:String,subJson : JSON) in json[JSON_KEY]
            {
                keyList.append(subJson.description)
            }
        }

    }
    
}