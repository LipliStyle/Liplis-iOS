//
//  ObjPreference.swift
//  Liplis
//  キャラクターごとの設定クラス
//
//  Created by sachin on 2015/04/17.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjPreference {
    ///=============================
    /// JSON管理
    var jman : JsonManager!
    var key : String!
    var keyList : Array<String> = []
    
    ///=============================
    /// プロパティ
    var charName : String!;          let KEY_CHAR_NAME  : String = "charName";                          //0
    var locationX : Int! = 300;      let KEY_LOCATION_X : String = "locationX";                         //1
    var locationY : Int! = 200;      let KEY_LOCATION_Y  : String = "locationY";                        //2
    var lpsMode : Int! = 0;          let KEY_LPSMODE : String = "lpsMode";                              //3
    //4は　けつばん
    var lpsSpeed : Int!;             let KEY_LPSSPEED : String = "lpsSpeed";                            //5
    var lpsWindow : Int!;            let KEY_LPSWINDOW : String = "lpsWindow";                          //6
    var lpsDisplayIcon : Int!;       let KEY_LPSDISPLAYICON : String = "lpsDisplayIcon";                //7
    var lpsHealth : Int!;            let KEY_LPSHELTH : String = "lpsHealth";                           //8
    
    var lpsNewsRange : Int!;         let KEY_LPSNEWSRANGE : String = "lpsNewsRange";                    //9
    var lpsNewsAlready : Int!;       let KEY_LPSNEWSALREADY : String = "lpsNewsAlready";                //10
    var lpsNewsRunOut : Int!;        let KEY_LPSNEWSRUNOUT : String = "lpsNewsRunOut";                  //11
    
    var lpsTopicNews : Int!;         let KEY_LPSTOPIC_NEWS : String = "lpsTopicNews";                   //12
    var lpsTopic2ch : Int!;          let KEY_LPSTOPIC_2CH : String = "lpsTopic2ch";                     //13
    var lpsTopicNico : Int!;         let KEY_LPSTOPIC_NICO : String = "lpsTopicNico";                   //14
    var lpsTopicRss : Int!;          let KEY_LPSTOPIC_RSS : String = "lpsTopicRss";                     //15
    var lpsTopicTwitter : Int!;      let KEY_LPSTOPIC_TWITTER : String = "lpsTopicTwitter";             //16
    var lpsTopicTwitterPu : Int!;    let KEY_LPSTOPIC_TWITTERPU : String = "lpsTopicTwitterPu";         //17
    var lpsTopicTwitterMy : Int!;    let KEY_LPSTOPIC_TWITTERMY : String = "lpsTopicTwitterMy";         //18
    var lpsTopicTwitterMode : Int!;  let KEY_LPSTOPIC_TWITTERMODE : String = "lpsTopicTwitterMode";     //19
    var lpsTopicCharMsg : Int!;      let KEY_LPSTOPIC_TOPICCHARMSG : String = "lpsTopicCharMsg";        //20
    
    var lpsWindowColor : String!;
    var lpsInterval : Double!
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    初期化処理　キーが存在した場合（既存データの読み出し）
    */
    init(key : String)
    {
        //キー取得
        self.key = key

        //キーリスト作成
        self.keyList = createKeyList()
        
        //JSONロード
        jman = JsonManager(key: self.key, valueKeyList: keyList)
        
        //データ取得
        setData()
        
        setMode()
        setWindow()
    }
    
    /**
    初期化処理　キーが存在しない場合（新規データ作成）
    */
    init()
    {
        //キー生成
        self.key = LiplisUtil.getRandormString(20)
        
        //キーリスト作成
        self.keyList = createKeyList()
        
        //JSONロード
        jman = JsonManager(key: self.key, valueKeyList: keyList)
        
        //初期値セット
        setInitData()
        
        //JSONを保存する
        saveSetting()

        setMode()
        setWindow()
    }
    
    /**
    初期値セット
    */
    func setInitData()
    {
        charName = ""
        locationX = 0
        locationY = 0
        lpsMode = 0
        lpsSpeed = 0
        lpsWindow = 0
        lpsDisplayIcon = 1
        lpsNewsRange = 2
        lpsNewsAlready = 0
        lpsNewsRunOut = 0
        lpsHealth = 1
        
        lpsTopicNews = 1
        lpsTopic2ch = 1
        lpsTopicNico = 1
        lpsTopicRss = 0
        lpsTopicTwitter = 0
        lpsTopicTwitterPu = 0
        lpsTopicTwitterMy = 0
        lpsTopicTwitterMode = 0
        lpsTopicCharMsg = 0
    }
    
    /**
    データ取得
    */
    func setData()
    {
        self.charName = jman.getData(KEY_CHAR_NAME)
        self.locationX = jman.getDataInt(KEY_LOCATION_X)
        self.locationY = jman.getDataInt(KEY_LOCATION_Y)
        self.lpsMode = jman.getDataInt(KEY_LPSMODE)
        self.lpsSpeed = jman.getDataInt(KEY_LPSSPEED)
        self.lpsWindow = jman.getDataInt(KEY_LPSWINDOW)
        self.lpsDisplayIcon = jman.getDataInt(KEY_LPSDISPLAYICON)
        self.lpsHealth = jman.getDataInt(KEY_LPSHELTH)
        
        self.lpsNewsRange = jman.getDataInt(KEY_LPSNEWSRANGE)
        self.lpsNewsAlready = jman.getDataInt(KEY_LPSNEWSALREADY)
        self.lpsNewsRunOut = jman.getDataInt(KEY_LPSNEWSRUNOUT)
        
        self.lpsTopicNews = jman.getDataInt(KEY_LPSTOPIC_NEWS)
        self.lpsTopic2ch = jman.getDataInt(KEY_LPSTOPIC_2CH)
        self.lpsTopicNico = jman.getDataInt(KEY_LPSTOPIC_NICO)
        self.lpsTopicRss = jman.getDataInt(KEY_LPSTOPIC_RSS)
        self.lpsTopicTwitter = jman.getDataInt(KEY_LPSTOPIC_TWITTER)
        self.lpsTopicTwitterPu = jman.getDataInt(KEY_LPSTOPIC_TWITTERPU)
        self.lpsTopicTwitterMy = jman.getDataInt(KEY_LPSTOPIC_TWITTERMY)
        self.lpsTopicTwitterMode = jman.getDataInt(KEY_LPSTOPIC_TWITTERMODE)
        self.lpsTopicCharMsg = jman.getDataInt(KEY_LPSTOPIC_TOPICCHARMSG)
    }
    
    /**
    キーリストを生成する
    */
    func createKeyList()->Array<String>
    {
        keyList = Array<String>()
        
        keyList.append(KEY_CHAR_NAME)
        keyList.append(KEY_LOCATION_X)
        keyList.append(KEY_LOCATION_Y)
        keyList.append(KEY_LPSMODE)
        keyList.append(KEY_LPSSPEED)
        keyList.append(KEY_LPSWINDOW)
        keyList.append(KEY_LPSDISPLAYICON)
        keyList.append(KEY_LPSHELTH)
        
        keyList.append(KEY_LPSNEWSRANGE)
        keyList.append(KEY_LPSNEWSALREADY)
        keyList.append(KEY_LPSNEWSRUNOUT)
        
        keyList.append(KEY_LPSTOPIC_NEWS)
        keyList.append(KEY_LPSTOPIC_2CH)
        keyList.append(KEY_LPSTOPIC_NICO)
        keyList.append(KEY_LPSTOPIC_RSS)
        keyList.append(KEY_LPSTOPIC_TWITTER)
        keyList.append(KEY_LPSTOPIC_TWITTERPU)
        keyList.append(KEY_LPSTOPIC_TWITTERMY)
        keyList.append(KEY_LPSTOPIC_TWITTERMODE)
        keyList.append(KEY_LPSTOPIC_TOPICCHARMSG)
        
        return keyList
    }
    
    /**
    JSONを削除する
    */
    func delPreference()
    {
        self.jman.delJson()
    }
    
    
    //============================================================
    //
    //設定保存
    //
    //============================================================
    func saveSetting()
    {
        jman.setStr(KEY_CHAR_NAME, value: charName)
        jman.setInt(KEY_LOCATION_X,value: locationX)
        jman.setInt(KEY_LOCATION_Y,value: locationY)
        jman.setInt(KEY_LPSMODE,value: lpsMode)
        jman.setInt(KEY_LPSSPEED,value: lpsSpeed)
        jman.setInt(KEY_LPSWINDOW,value: lpsWindow)
        jman.setInt(KEY_LPSDISPLAYICON,value: lpsDisplayIcon)
        jman.setInt((KEY_LPSHELTH),value: lpsHealth)
             
        jman.setInt(KEY_LPSNEWSRANGE,value: lpsNewsRange)
        jman.setInt(KEY_LPSNEWSALREADY,value: lpsNewsAlready)
        jman.setInt(KEY_LPSNEWSRUNOUT,value: lpsNewsRunOut)

        jman.setInt(KEY_LPSTOPIC_NEWS,value: lpsTopicNews)
        jman.setInt(KEY_LPSTOPIC_2CH,value: lpsTopic2ch)
        jman.setInt(KEY_LPSTOPIC_NICO,value: lpsTopicNico)
        jman.setInt(KEY_LPSTOPIC_RSS,value: lpsTopicRss)
        jman.setInt(KEY_LPSTOPIC_TWITTER,value: lpsTopicTwitter)
        jman.setInt(KEY_LPSTOPIC_TWITTERPU,value: lpsTopicTwitterPu)
        jman.setInt(KEY_LPSTOPIC_TWITTERMY,value: lpsTopicTwitterMy)
        jman.setInt(KEY_LPSTOPIC_TWITTERMODE,value: lpsTopicTwitterMode)
        jman.setInt(KEY_LPSTOPIC_TOPICCHARMSG,value: lpsTopicCharMsg)
        
        jman.saveSetting()
    }
    
    func saveDataFromIdx(idx : Int, val : Int)
    {
        setDataFromIdx(idx,val: val)
        saveSetting()
    }
    
    //============================================================
    //
    //設定処理
    //
    //============================================================
    
    /**
        モードとインターバルの設定
    */
    func setMode()
    {
        if(self.lpsMode == 0)
        {
            self.lpsInterval = 10.0
        }
        else if(self.lpsMode == 1)
        {
            self.lpsInterval = 30.0
        }
        else if(self.lpsMode == 2)
        {
            self.lpsInterval = 60.0
        }
        else
        {
            self.lpsInterval = 10.0
        }
    }
    
    /**
        ウインドウカラーを設定する
    */
    func setWindow()
    {
        switch(lpsWindow)
        {
        case 0:lpsWindowColor = "window.png"
            break
        case 1:lpsWindowColor = "window_blue.png"
            break
        case 2:lpsWindowColor = "window_green.png"
            break
        case 3:lpsWindowColor = "window_pink.png"
            break
        case 4:lpsWindowColor = "window_purple.png"
            break
        case 5:lpsWindowColor = "window_red.png"
            break
        case 6:lpsWindowColor = "window_yellow.png"
            break
        default:lpsWindowColor = "window.png"
            break
        }
    }
    
    /**
        ニュースフラグを取得する
    */
    func getNewsFlg()->String
    {
        var result : String = ""
        
        result = result + String(lpsTopicNews) + ","
        result = result + String(lpsTopic2ch) + ","
        result = result + String(lpsTopicNico) + ","
        result = result + String(lpsTopicRss) + ","
        result = result + String(lpsTopicTwitterPu) + ","
        result = result + String(lpsTopicTwitterMy) + ","
        result = result + String(lpsTopicTwitter)
        
        return result
    }
    
    /**
        ニュース範囲文字列を取得する
    */
    func getLpsNewsRangeStr()->String
    {
        switch(lpsNewsRange)
        {
        case 0:
            return "1"
        case 1:
            return "3"
        case 2:
            return "6"
        case 3:
            return "12"
        case 4:
            return "24"
        case 5:
            return "72"
        case 6:
            return "168"
        default:
            return "9999"
        }
    }
    
    
    /**
    インデックスから値を設定する
    */
    func setDataFromIdx(idx : Int, val : Int)
    {
        switch(idx)
        {
        case 1:
            self.locationX = val
            break
        case 2:
            locationY = val
            break
        case 3:
            lpsMode = val
            setMode()
            break
        case 5:
            lpsSpeed = val
            break
        case 6:
            lpsWindow = val
            setWindow()
            break
        case 7:
            lpsDisplayIcon = val
            break
        case 8:
            lpsHealth = val
            break
        case 9:
            lpsNewsRange = val
            break
        case 10:
            lpsNewsAlready = val
            break
        case 11:
            lpsNewsRunOut = val
            break
        case 12:
            lpsTopicNews = val
            break
        case 13:
            lpsTopic2ch = val
            break
        case 14:
            lpsTopicNico = val
            break
        case 15:
            lpsTopicRss = val
            break
        case 16:
            lpsTopicTwitter = val
            break
        case 17:
            lpsTopicTwitterPu = val
            break
        case 18:
            lpsTopicTwitterMy = val
            break
        case 19:
            lpsTopicTwitterMode = val
            break
        case 20:
            lpsTopicCharMsg = val
            break
        default:
            break
        }
    }

}