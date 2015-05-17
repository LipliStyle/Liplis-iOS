//
//  JsonListManager.swift
//  Liplis
//
//  Liplisウィジェットの保存キーの管理を行うクラス
//
//アップデート履歴
//   2015/04/27 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　リファクタリング
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
    internal var keyList : Array<String> = []
    
    ///=============================
    /// 書き込みキー
    internal let JSON_KEY = "keylist"
    
    /**
    コンストラクター
    */
    internal override init()
    {
        //親の初期化
        super.init()
        
        //復活させる
        self.getKeyList()
    }
    
    /**
    キーを追加する
    */
    internal func addKey(key : String)
    {
        var flgHit : Bool = false
        
        //キーの存在チェック
        for str in self.keyList
        {
            if str == key
            {
                flgHit = true
            }
        }
        
        //該当キーがなければ追加する
        if !flgHit
        {
            self.keyList.append(key)
            self.saveKeyList()
        }

    }
    
    /**
    キーを削除する
    */
    internal func delKey(pKey : String)
    {
        var idx : Int = 0
        
        for key in self.keyList
        {
            if(key == pKey)
            {
                self.keyList.removeAtIndex(idx)
                self.saveKeyList()
                return
            }
            
            idx++
        }
    }
    
    /**
    キーを削除する
    */
    internal func delAllKey()
    {
        self.keyList.removeAll(keepCapacity: false)
        self.saveKeyList()
    }
    
    /**
    キーリストを保存する
    */
    internal func saveKeyList()
    {
        var jsonStr : StringBuilder = StringBuilder()
        
        //開始かっこ
        jsonStr.append("{\"")
        jsonStr.append(JSON_KEY)
        jsonStr.append("\":[")
        
        if self.keyList.count >= 2
        {
            //最後の1個以外全部入れる
            for idx in 0...keyList.count-2
            {
                jsonStr.append("\"" + self.keyList[idx] + "\",")
            }
            
            //最後の1個を入れる
            jsonStr.append("\"" + self.keyList[keyList.count-1] + "\"")
        }
        else if keyList.count == 1
        {
            //要素が1個の場合
            jsonStr.append("\"" + self.keyList[0] + "\"")
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
    internal func getKeyList()
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
                self.keyList.append(subJson.description)
            }
        }

    }
    
}