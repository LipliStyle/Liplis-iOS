//
//  LiplisSkinData.swift
//  Liplis
//
//  スキンデータのインスタンス
//
//アップデート履歴
//   2015/05/03 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/14 ver1.3.0 ディスポーズ処理追加(キャラクターデータリロード対応)
//
//  Created by sachin on 2015/05/03.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit
import Foundation
class LiplisSkinData
{
    //=================================
    //キャラクター名
    internal var charDefine : String = ""
    internal var charName : String = ""
    internal var charDescription : String = ""
    internal var flgDefautlt : Bool! = false
    
    //=================================
    //ディレクトリ
    internal var pathBase : String! = ""         //ベースのパス
    internal var pathBody: String! = ""          //ボディのパス
    internal var pathWindow : String! = ""       //ウインドウのパス
    
    internal var urlBase : NSURL!                //ベースのパス
    internal var xmlSkin : NSURL!                //skin.xmlのURL
    internal var xmlBody : NSURL!                //body.xmlのURL
    internal var xmlChat : NSURL!                //char.xmlのURL
    internal var xmlTouch : NSURL!               //touch.xmlのURL
    internal var xmlVersion : NSURL!             //version.xmlのURL
    
    internal var lpsSkin : ObjLiplisSkin!        //スキンファイルオブジェクト
    internal var lpsBody : ObjLiplisBody!        //ボディオブジェクト

    internal var imgIco : UIImage!               //アイコンイメージ
    
    /**
    イニシャライザ
    */
    internal init(charName : String)
    {
        //キャラクター名
        self.charName = charName
        
        //ベースパス
        self.pathBase = LiplisFileManager.getDocumentRoot()
        
        //サブパス
        self.pathBody = pathBase + "/" + charName + "/body"
        self.pathWindow = pathBase + "/" + charName + "/window"
        
        //ベースURL
        self.urlBase = LiplisFileManager.getDocumentRootUrl()
        
        //XMLパス
        self.xmlSkin = urlBase.URLByAppendingPathComponent(charName + "/skin.xml")
        self.xmlBody = urlBase.URLByAppendingPathComponent(charName + "/define/body.xml")
        self.xmlChat = urlBase.URLByAppendingPathComponent(charName + "/define/chat.xml")
        self.xmlTouch = urlBase.URLByAppendingPathComponent(charName + "/define/touch.xml")
        self.xmlVersion = urlBase.URLByAppendingPathComponent(charName + "/define/version.xml")

        //XML読み込み
        self.lpsSkin = ObjLiplisSkin(url: xmlSkin)
        self.lpsBody = ObjLiplisBody(url: xmlBody, bodyPath: self.pathBody)
        
        //キャラクター説明文の読み込み
        self.charDefine = lpsSkin.charName
        self.charDescription = lpsSkin.charIntroduction
        
        //ボディファイルロード
        self.imgIco = UIImage(contentsOfFile: pathWindow + "/icon.png")
    }
    
    /**
    デフォルトイニシャライザ
    デフォリリのスキンデータ作成
    */
    internal init()
    {
        //キャラクター名
        self.charName = "LiliRenew"
        self.charDefine = LiplisDefine.SKIN_NAME_DEFAULT
        self.charDescription = "リプリスシスターズの姉 Liliです。おしとやかにおしゃべりします。"
        self.flgDefautlt = true 
        self.pathBase = ""
        self.pathBody = ""
        self.pathWindow = ""
        
        //ベースURL
        self.urlBase = nil
        
        //XMLパス
        self.xmlSkin = nil
        self.xmlBody = nil
        self.xmlChat = nil
        self.xmlTouch = nil
        self.xmlVersion = nil
        
        //XML読み込み
        self.lpsSkin = ObjLiplisSkin(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skin", ofType: "xml")!))
        self.lpsBody = nil
        
        //ボディファイルロード
        self.imgIco = UIImage(named: "liliIcon.png")!
    }
    
    /**
    破棄
    */
    internal func dispose()
    {
        self.lpsSkin = nil
        self.lpsBody = nil
        self.imgIco = nil
    }
}