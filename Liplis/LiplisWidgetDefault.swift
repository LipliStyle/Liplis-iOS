//
//  LiplisWidgetDefault.swift
//  Liplis
//
//  ウィジェットのインスタンス
//  スキンデータを読み込めるようにしたことに伴い、プリインストールのリリデータは、本クラスで読むようにする。
//  XML、画像データはプリセットデータを読み込む
//  立ち絵データは「ObjLiplisBodyDefault」クラスを使うことにより、プリセット画像をロードする
//
//アップデート履歴
//   2015/05/05 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/12 ver1.1.0 リファクタリング
//
//  Created by sachin on 2015/05/05.
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
    internal override init(desk:ViewDeskTop!, os : ObjPreference, lpsSkinData : LiplisSkinData!)
    {
        super.init(desk: desk, os: os, lpsSkinData: lpsSkinData)
    }
    
    /*
    XML読み込み
    */
    internal override func initXml()
    {
        //プリセットファイルの読み込み
        self.lpsChat = ObjLiplisChat(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("chat", ofType: "xml")!))
        self.lpsBody = ObjLiplisBodyDefault(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("body", ofType: "xml")!))
        self.lpsSkin = ObjLiplisSkin(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skin", ofType: "xml")!))
        self.lpsTouch = ObjLiplisTouch(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("touch", ofType: "xml")!))
        self.lpsVer = ObjLiplisVersion(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("version", ofType: "xml")!))
        self.lpsIcon = ObjLiplisIcon()
    }
    
    /*
    ウインドウのセット
    オーバーライドが必要
    */
    internal override func setWindow()
    {
        self.imgWindow.image = UIImage(named: os.lpsWindowColor)
    }
    
    /*
    ボディの更新
    */
    internal override func updateBody()->Bool
    {
        //感情変化セット
        self.setObjectBody()
        
        //口パクカウント
        if(self.flgChatting)
        {
            if(self.cntMouth == 1){self.cntMouth = 2}
            else             {self.cntMouth = 1}
        }
        else
        {
            self.cntMouth = 1
        }
        
        //めぱちカウント
        if(self.cntBlink == 0){self.cntBlink = self.getBlincCnt()}
        else             {self.cntBlink = self.cntBlink - 1}
        
        autoreleasepool { () -> () in
            self.imgBody.image = nil
            self.imgBody.image = self.ob.getLiplisBodyImgIdInsDefault(self.getBlinkState(),mouthState: self.cntMouth)
            self.imgBody.setNeedsDisplay()
        }

        return true
    }
}