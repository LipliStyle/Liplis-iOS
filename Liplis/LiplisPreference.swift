//
//  ObjPreferenceLiplis.swift
//  Liplis
//  リプリス全体の設定クラス
//
//  Created by sachin on 2015/04/18.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class LiplisPreference : ObjPreferenceBase{
    var lpsUid : String!                //0
    var lpsAutoSleep : Int!             //1
    var lpsAutoWakeup : Int!            //2
    var lpsTalkWindowClickMode : Int!   //3
    var lpsBrowserMode : Int!           //4
    var lpsAutoRescue : Int!             //5
    
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
        setUID()                                                                        //ユーザーID
        self.lpsAutoSleep = getLiplisSettingInt("lpsAutoSleep")                         //オートスリープ
        self.lpsAutoWakeup = getLiplisSettingInt("lpsAutoWakeup")                       //オートウェイクアップ
        self.lpsTalkWindowClickMode = getLiplisSettingInt("lpsTalkWindowClickMode")
        self.lpsBrowserMode = getLiplisSettingInt("lpsBrowserMode")
        self.lpsAutoRescue = getLiplisSettingInt("lpsAutoRescue")
        
        //設定再保存
        saveSetting()
    }
    
    /**
        UID生成
    */
    func setUID()
    {
        var uid = getLiplisSetting("lpsUid")
        
        if uid == ""
        {
            lpsUid = NSUUID().UUIDString
        }
        else
        {
            lpsUid = uid
        }
    }
    
    //============================================================
    //
    //設定保存
    //
    //============================================================
    func saveSetting()
    {
        setLiplisSetting("lpsUid",value: lpsUid)
        setLiplisSettingInt("lpsAutoSleep",value: lpsAutoSleep)
        setLiplisSettingInt("lpsAutoWakeup",value: lpsAutoWakeup)
        setLiplisSettingInt("lpsTalkWindowClickMode",value: lpsTalkWindowClickMode)
        setLiplisSettingInt("lpsBrowserMode",value: lpsBrowserMode)
        setLiplisSettingInt("lpsAutoRescue",value: lpsAutoRescue)
    }
    func saveDataFromIdx(idx : Int, val : Int)
    {
        setDataFromIdx(idx,val: val)
        saveSetting()
    }

    /**
    インデックスから値を設定する
    */
    func setDataFromIdx(idx : Int, val : Int)
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