//
//  LiplisWidgetSkelton.swift
//  Liplis
//
//  Created by kosuke on 2015/05/03.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit
import Foundation
class LiplisSkinData
{
    //=================================
    //キャラクター名
    var charDefine : String = ""
    var charName : String = ""
    var charDescription : String = ""
    var flgDefautlt : Bool! = false
    
    //=================================
    //ディレクトリ
    var pathBase : String! = ""         //ベースのパス
    var pathBody: String! = ""          //ボディのパス
    var pathWindow : String! = ""       //ウインドウのパス
    
    var urlBase : NSURL!                //ベースのパス
    var xmlSkin : NSURL!                //skin.xmlのURL
    var xmlBody : NSURL!                //body.xmlのURL
    var xmlChat : NSURL!                //char.xmlのURL
    var xmlTouch : NSURL!               //touch.xmlのURL
    var xmlVersion : NSURL!             //version.xmlのURL
    
    var lpsSkin : ObjLiplisSkin!        //スキンファイルオブジェクト
    var lpsBody : ObjLiplisBody!        //ボディオブジェクト

    var imgIco : UIImage!               //アイコンイメージ
    
    init(charName : String)
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
    
    init()
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
        self.lpsSkin = ObjLiplisSkin(url:NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skin", ofType: "xml")!)!)
        self.lpsBody = nil
        
        //ボディファイルロード
        self.imgIco = UIImage(named: "liliIcon.png")!
    }
    
}