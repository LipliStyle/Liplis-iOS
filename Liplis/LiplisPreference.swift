//
//  ObjPreferenceLiplis.swift
//  Liplis
//  リプリス全体の設定クラス
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
class LiplisPreference : ObjPreferenceBase{
    internal var lpsUid : String!                //0
    internal var lpsAutoSleep : Int!             //1
    internal var lpsAutoWakeup : Int!            //2
    internal var lpsTalkWindowClickMode : Int!   //3
    internal var lpsBrowserMode : Int!           //4
    internal var lpsAutoRescue : Int!            //5
    
    //============================================================
    //
    //シングルトンインスタンス
    //
    //============================================================
    class var SharedInstance : LiplisPreference
    {
        struct Static
        {
            static let instance : LiplisPreference = LiplisPreference()
        }
        
        return Static.instance
    }
    
    
    //============================================================
    //
    //初期化処理
    //シングルトンのため、コンストラクターは使用不可
    //
    //============================================================
    private init(lpsUid : String,lpsAutoSleep : Int,lpsAutoWakeup : Int, lpsTalkWindowClickMode : Int, lpsBrowserMode : Int)
    {
        self.lpsUid = lpsUid
        self.lpsAutoSleep = lpsAutoSleep
        self.lpsAutoWakeup = lpsAutoWakeup
        self.lpsTalkWindowClickMode = lpsTalkWindowClickMode
        self.lpsBrowserMode = lpsBrowserMode
    }
    override private init()
    {
        super.init()
        self.setUID()                                                                        //ユーザーID
        self.lpsAutoSleep = getLiplisSettingInt("lpsAutoSleep")                         //オートスリープ
        self.lpsAutoWakeup = getLiplisSettingInt("lpsAutoWakeup")                       //オートウェイクアップ
        self.lpsTalkWindowClickMode = getLiplisSettingInt("lpsTalkWindowClickMode")
        self.lpsBrowserMode = getLiplisSettingInt("lpsBrowserMode")
        self.lpsAutoRescue = getLiplisSettingInt("lpsAutoRescue")
        
        //設定再保存
        self.saveSetting()
    }
    
    /**
        UID生成
    */
    internal func setUID()
    {
        let uid = getLiplisSetting("lpsUid")
        
        if uid == ""
        {
            self.lpsUid = NSUUID().UUIDString
        }
        else
        {
            self.lpsUid = uid
        }
    }
    
    //============================================================
    //
    //設定保存
    //
    //============================================================
   internal func saveSetting()
    {
        self.setLiplisSetting("lpsUid",value: lpsUid)
        self.setLiplisSettingInt("lpsAutoSleep",value: lpsAutoSleep)
        self.setLiplisSettingInt("lpsAutoWakeup",value: lpsAutoWakeup)
        self.setLiplisSettingInt("lpsTalkWindowClickMode",value: lpsTalkWindowClickMode)
        self.setLiplisSettingInt("lpsBrowserMode",value: lpsBrowserMode)
        self.setLiplisSettingInt("lpsAutoRescue",value: lpsAutoRescue)
    }
    internal func saveDataFromIdx(idx : Int, val : Int)
    {
        self.setDataFromIdx(idx,val: val)
        self.saveSetting()
    }

    /**
    インデックスから値を設定する
    */
    internal func setDataFromIdx(idx : Int, val : Int)
    {
        switch(idx)
        {
        case 1:
            self.lpsAutoSleep = val
            break
        case 2:
            lpsAutoWakeup = val
            break
        case 3:
            lpsAutoRescue = val
            break
        case 4:
            lpsTalkWindowClickMode = val
            break
        case 5:
            lpsBrowserMode = val
            break

        default:
            break
        }
    }


}