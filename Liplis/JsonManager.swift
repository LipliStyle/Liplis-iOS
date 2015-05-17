//
//  JsonManagement.swift
//  Liplis
//
//  Json管理クラス
//
//アップデート履歴
//   2015/04/27 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　swift1.2対応
//                        サブストリングの取り扱い、UTF16カウントの取り扱い変更
//
//  Created by sachin on 2015/04/27.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class JsonManager : ObjPreferenceBase
{
    ///=============================
    /// キーリスト
    internal var valueKeyList : Array<String> = []
    
    ///=============================
    /// キーバリューセット
    internal var dataSet : Dictionary<String,String>!        //実データセット
    internal var dataSetJson : Dictionary<String,String>!   //Json用データセット
    
    ///=============================
    /// Json管理
    internal var key : String
    internal var json : JSON!
    internal var jsonStr : String!
    
    /**
    初期化
    */
    internal init(key : String, valueKeyList : Array<String>)
    {
        self.valueKeyList = valueKeyList
        self.dataSet = Dictionary<String,String>()
        self.dataSetJson = Dictionary<String,String>()
        self.key = key
        
        super.init()
        
        //プリファレンスから指定キーのデータを読み出し、JSONパースする
        self.jsonStr = getSetting(key, defaultValue: "")
        self.json = getJsonFromString(jsonStr)
        
        //JSONをディクショナリーにロードする
        self.loadJson()
    }
    
    /**
    プリファレンスからデータを読み込み、キーリストに従ってデータを生成する
    */
    internal func loadJson()
    {
        for key in valueKeyList
        {
            if self.json[key].string != nil
            {
                self.setStr(key,value: self.json[key].description)
            }
            else if self.json[key].int32 != nil
            {
                self.setInt(key,value: self.json[key].description.toInt()!)
            }
            else
            {
                self.setStr(key,value: "")
            }
        }
    }
    
    /**
    プリファレンスを削除する
    */
    internal func delJson()
    {
        self.deletePreference(self.key)
    }

    //============================================================
    //
    //操作メソッド
    //
    //============================================================
    
    /**
    要素(文字)を入れる
    */
    internal func setStr(key : String, value : String)
    {
        self.dataSet[key] = value
        self.dataSetJson[key] = "\"" + key + "\":\"" + value + "\""
    }
    
    /**
    要素(数字)を入れる
    */
    internal func setInt(key : String, value : Int)
    {
        self.dataSet[key] = String(value)
        self.dataSetJson[key] = "\"" + key + "\":" + String(value)
    }
    
    /**
    要素を取得する
    */
    internal func getData(key : String)->String
    {
        return self.dataSet[key]!
    }
    internal func getDataInt(key : String)->Int
    {
        if self.dataSet[key]!.toInt() != nil
        {
            return dataSet[key]!.toInt()!
        }
        else
        {
            return 0
        }
    }
    
    //============================================================
    //
    //保存処理
    //
    //============================================================
    
    /**
    JSONを保存する
    */
    internal func saveSetting()
    {
        self.wirtePreference(self.key, value: getJson())
    }

    /**
    JSONとして取得する
    */
    internal func getJson()->String
    {
        var jsonStr : StringBuilder = StringBuilder()
        
        //開始かっこ
        jsonStr.append("{")
        
        if dataSetJson.count >= 2
        {
            for (key,value) in dataSetJson
            {
                jsonStr.append(value + ",")
            }
            
            //最後の1文字を消して、閉じかっこをつける
            var str = jsonStr.toString()
            str = str.substringToIndex(advance(str.startIndex,count(str.utf16)  - 1))
            str = str + "}"
            
            return str
        }
        else if dataSetJson.count == 1
        {
            //要素が1個の場合
            for (key,val) in dataSetJson
            {
                jsonStr.append(val)
            }

            //とじかっこ
            jsonStr.append("}")
            
            return jsonStr.toString()
        }
        else
        {
            //とじかっこ
            jsonStr.append("}")
            
            return jsonStr.toString()
        }
    }
    
}