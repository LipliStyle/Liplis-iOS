//
//  JsonManagement.swift
//  Liplis
//
//  Created by sachin on 2015/04/27.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class JsonManager : ObjPreferenceBase
{
    ///=============================
    /// キーリスト
    var valueKeyList : Array<String> = []
    
    ///=============================
    /// キーバリューセット
    var dataSet : Dictionary<String,String>!        //実データセット
    var dataSetJson : Dictionary<String,String>!   //Json用データセット
    
    ///=============================
    /// Json管理
    var key : String
    var json : JSON!
    var jsonStr : String!
    
    /**
    初期化
    */
    init(key : String, valueKeyList : Array<String>)
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
    func loadJson()
    {
        for key in valueKeyList
        {
            if self.json[key].string != nil
            {
                setStr(key,value: self.json[key].description)
            }
            else if self.json[key].int32 != nil
            {
                setInt(key,value: self.json[key].description.toInt()!)
            }
            else
            {
                setStr(key,value: "")
            }
        }
    }
    
    /**
    プリファレンスを削除する
    */
    func delJson()
    {
        deletePreference(self.key)
    }

    //============================================================
    //
    //操作メソッド
    //
    //============================================================
    
    /**
    要素(文字)を入れる
    */
    func setStr(key : String, value : String)
    {
        dataSet[key] = value
        dataSetJson[key] = "\"" + key + "\":\"" + value + "\""
    }
    
    /**
    要素(数字)を入れる
    */
    func setInt(key : String, value : Int)
    {
        dataSet[key] = String(value)
        dataSetJson[key] = "\"" + key + "\":" + String(value)
    }
    
    /**
    要素を取得する
    */
    func getData(key : String)->String
    {
        return dataSet[key]!
    }
    func getDataInt(key : String)->Int
    {
        if dataSet[key]!.toInt() != nil
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
    func saveSetting()
    {
        wirtePreference(self.key, value: getJson())
    }

    /**
    JSONとして取得する
    */
    func getJson()->String
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
            str = str.substringToIndex(advance(str.startIndex,str.utf16Count - 1))

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