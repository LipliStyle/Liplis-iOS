//
//  ObjPreference.swift
//  Liplis
//
//  キャラクターごとの設定クラス
//
//アップデート履歴
//   2015/04/17 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0 リファクタリング
//   2015/05/19 ver1.4.1 デフォルト設定話題をニュースのみに変更
//
//  Created by sachin on 2015/04/17.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjPreference {
    ///=============================
    /// JSON管理
    internal var jman : JsonManager!
    internal var key : String!
    internal var keyList : Array<String> = []
    
    ///=============================
    /// プロパティ
    internal var charName               : String!;      internal let KEY_CHAR_NAME              : String = "charName";               //0
    internal var locationX              : Int! = 300;   internal let KEY_LOCATION_X             : String = "locationX";              //1
    internal var locationY              : Int! = 200;   internal let KEY_LOCATION_Y             : String = "locationY";              //2
    internal var lpsMode                : Int! = 0;     internal let KEY_LPSMODE                : String = "lpsMode";                //3
    //4は　けつばん
    internal var lpsSpeed               : Int!;         internal let KEY_LPSSPEED               : String = "lpsSpeed";               //5
    internal var lpsWindow              : Int!;         internal let KEY_LPSWINDOW              : String = "lpsWindow";              //6
    internal var lpsDisplayIcon         : Int!;         internal let KEY_LPSDISPLAYICON         : String = "lpsDisplayIcon";         //7
    internal var lpsHealth              : Int!;         internal let KEY_LPSHELTH               : String = "lpsHealth";              //8
    
    internal var lpsNewsRange           : Int!;         internal let KEY_LPSNEWSRANGE           : String = "lpsNewsRange";           //9
    internal var lpsNewsAlready         : Int!;         internal let KEY_LPSNEWSALREADY         : String = "lpsNewsAlready";         //10
    internal var lpsNewsRunOut          : Int!;         internal let KEY_LPSNEWSRUNOUT          : String = "lpsNewsRunOut";          //11
    
    internal var lpsTopicNews           : Int!;         internal let KEY_LPSTOPIC_NEWS          : String = "lpsTopicNews";           //12
    internal var lpsTopic2ch            : Int!;         internal let KEY_LPSTOPIC_2CH           : String = "lpsTopic2ch";            //13
    internal var lpsTopicNico           : Int!;         internal let KEY_LPSTOPIC_NICO          : String = "lpsTopicNico";           //14
    internal var lpsTopicRss            : Int!;         internal let KEY_LPSTOPIC_RSS           : String = "lpsTopicRss";            //15
    internal var lpsTopicTwitter        : Int!;         internal let KEY_LPSTOPIC_TWITTER       : String = "lpsTopicTwitter";        //16
    internal var lpsTopicTwitterPu      : Int!;         internal let KEY_LPSTOPIC_TWITTERPU     : String = "lpsTopicTwitterPu";      //17
    internal var lpsTopicTwitterMy      : Int!;         internal let KEY_LPSTOPIC_TWITTERMY     : String = "lpsTopicTwitterMy";      //18
    internal var lpsTopicTwitterMode    : Int!;         internal let KEY_LPSTOPIC_TWITTERMODE   : String = "lpsTopicTwitterMode";    //19
    internal var lpsTopicCharMsg        : Int!;         internal let KEY_LPSTOPIC_TOPICCHARMSG  : String = "lpsTopicCharMsg";        //20
    
    internal var lpsWindowColor         : String!;
    internal var lpsInterval            : Double!
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    初期化処理　キーが存在した場合（既存データの読み出し）
    */
    internal init(key : String)
    {
        //キー取得
        self.key = key

        //キーリスト作成
        self.keyList = createKeyList()
        
        //JSONロード
        self.jman = JsonManager(key: self.key, valueKeyList: keyList)
        
        //データ取得
        self.setData()
        
        //モード設定
        self.setMode()
        
        //ウインドウ設定
        self.setWindow()
    }
    
    /**
    初期化処理　キーが存在しない場合（新規データ作成）
    */
    internal init()
    {
        //キー生成
        self.key = LiplisUtil.getRandormString(20)
        
        //キーリスト作成
        self.keyList = createKeyList()
        
        //JSONロード
        self.jman = JsonManager(key: self.key, valueKeyList: keyList)
        
        //初期値セット
        self.setInitData()
        
        //JSONを保存する
        self.saveSetting()

        //モード設定
        self.setMode()
        
        //ウインドウ設定
        self.setWindow()
    }
    
    /**
    初期値セット
    */
    internal func setInitData()
    {
        self.charName = ""
        self.locationX = 0
        self.locationY = 0
        self.lpsMode = 0
        self.lpsSpeed = 0
        self.lpsWindow = 0
        self.lpsDisplayIcon = 1
        self.lpsNewsRange = 2
        self.lpsNewsAlready = 0
        self.lpsNewsRunOut = 0
        self.lpsHealth = 1
        
        self.lpsTopicNews = 1
        self.lpsTopic2ch = 0
        self.lpsTopicNico = 0
        self.lpsTopicRss = 0
        self.lpsTopicTwitter = 0
        self.lpsTopicTwitterPu = 0
        self.lpsTopicTwitterMy = 0
        self.lpsTopicTwitterMode = 0
        self.lpsTopicCharMsg = 0
    }
    
    /**
    データ取得
    */
    internal func setData()
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
    internal func createKeyList()->Array<String>
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
    internal func delPreference()
    {
        self.jman.delJson()
    }
    
    
    //============================================================
    //
    //設定保存
    //
    //============================================================
    internal func saveSetting()
    {
        self.jman.setStr(KEY_CHAR_NAME, value: charName)
        self.jman.setInt(KEY_LOCATION_X,value: locationX)
        self.jman.setInt(KEY_LOCATION_Y,value: locationY)
        self.jman.setInt(KEY_LPSMODE,value: lpsMode)
        self.jman.setInt(KEY_LPSSPEED,value: lpsSpeed)
        self.jman.setInt(KEY_LPSWINDOW,value: lpsWindow)
        self.jman.setInt(KEY_LPSDISPLAYICON,value: lpsDisplayIcon)
        self.jman.setInt((KEY_LPSHELTH),value: lpsHealth)
             
        self.jman.setInt(KEY_LPSNEWSRANGE,value: lpsNewsRange)
        self.jman.setInt(KEY_LPSNEWSALREADY,value: lpsNewsAlready)
        self.jman.setInt(KEY_LPSNEWSRUNOUT,value: lpsNewsRunOut)

        self.jman.setInt(KEY_LPSTOPIC_NEWS,value: lpsTopicNews)
        self.jman.setInt(KEY_LPSTOPIC_2CH,value: lpsTopic2ch)
        self.jman.setInt(KEY_LPSTOPIC_NICO,value: lpsTopicNico)
        self.jman.setInt(KEY_LPSTOPIC_RSS,value: lpsTopicRss)
        self.jman.setInt(KEY_LPSTOPIC_TWITTER,value: lpsTopicTwitter)
        self.jman.setInt(KEY_LPSTOPIC_TWITTERPU,value: lpsTopicTwitterPu)
        self.jman.setInt(KEY_LPSTOPIC_TWITTERMY,value: lpsTopicTwitterMy)
        self.jman.setInt(KEY_LPSTOPIC_TWITTERMODE,value: lpsTopicTwitterMode)
        self.jman.setInt(KEY_LPSTOPIC_TOPICCHARMSG,value: lpsTopicCharMsg)
        
        self.jman.saveSetting()
    }
    
    internal func saveDataFromIdx(idx : Int, val : Int)
    {
        self.setDataFromIdx(idx,val: val)
        self.saveSetting()
    }
    
    //============================================================
    //
    //設定処理
    //
    //============================================================
    
    /**
        モードとインターバルの設定
    */
    internal func setMode()
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
    internal func setWindow()
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
    internal func getNewsFlg()->String
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
    internal func getLpsNewsRangeStr()->String
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
    internal func setDataFromIdx(idx : Int, val : Int)
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