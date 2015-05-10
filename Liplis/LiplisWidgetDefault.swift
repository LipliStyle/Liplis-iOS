//
//  LiplisWidgetDefault.swift
//  Liplis
//
//  Created by kosuke on 2015/05/05.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
import Foundation

class LiplisWidgetDefault : LiplisWidget {
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    デフォルトイニシャライザ
    */
    override init(desk:ViewDeskTop!, os : ObjPreference, lpsSkinData : LiplisSkinData!)
    {
        super.init(desk: desk, os: os, lpsSkinData: lpsSkinData)
    }
    
    /*
    XML読み込み
    */
    override func initXml()
    {
        //ボディインスタンス
        lpsChat = ObjLiplisChat(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("chat", ofType: "xml")!)!)
        lpsBody = ObjLiplisBodyDefault(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("body", ofType: "xml")!)!)
        lpsSkin = ObjLiplisSkin(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skin", ofType: "xml")!)!)
        lpsTouch = ObjLiplisTouch(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("touch", ofType: "xml")!)!)
        lpsVer = ObjLiplisVersion(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("version", ofType: "xml")!)!)
        lpsIcon = ObjLiplisIcon()
    }
    
    /*
    ウインドウのセット
    オーバーライドが必要
    */
    override func setWindow()
    {
        imgWindow.image = UIImage(named: os.lpsWindowColor)
    }
    
    /*
    ボディの更新
    */
    override func updateBody()->Bool
    {
        //感情変化セット
        setObjectBody()
        
        //口パクカウント
        if(flgChatting)
        {
            if(cntMouth == 1){cntMouth = 2}
            else             {cntMouth = 1}
        }
        else
        {
            cntMouth = 1
        }
        
        //めぱちカウント
        if(cntBlink == 0){cntBlink = getBlincCnt()}
        else             {cntBlink = cntBlink - 1}
        
        autoreleasepool { () -> () in
            self.imgBody.image = nil
            //self.imgBody.image = self.ob.getLiplisBodyImgId(self.getBlinkState(),mouthState: self.cntMouth)
            self.imgBody.image = self.ob.getLiplisBodyImgIdInsDefault(self.getBlinkState(),mouthState: self.cntMouth)
            self.imgBody.setNeedsDisplay()
        }
        
        
        return true
    }
}