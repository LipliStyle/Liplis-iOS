//
//  ObjLiplisBodyChar.swift
//  Liplis
//
//  Created by sachin on 2015/05/05.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
import Foundation
class ObjLiplisBodyDefault : ObjLiplisBody {

    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    デフォルトイニシャライザ
    */
    init(url : NSURL)
    {
        //スーパークラスのイニット
        super.init()
        
        //リストの初期化
        initList()
        
        //スリープ画像の初期化
        initSleep()
        
        //プロパティの初期化
        initProperty()
        
        //ロードXML
        loadXml(url)
        
        //アスペクト比算出
        culcAspectRatio()
    }
    
    /**
    おやすみ画像のセット
    */
    override func initSleep()
    {
        sleep = UIImage(named: SLEEP_FILE_NAME)
    }
    
    /**
    ノーマルグラフィックを取得する
    */
    override func getNormalGraphic()->UIImage
    {
        return normalList[0].getLiplisBodyImgIdInsDefault(0,mouthState: 0)
    }
    
    /**
    タグの読み始めに呼ばれる
    */
    override func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!)
    {
        _ParseKey = elementName
        
        if elementName == "normal" {_body = ObjBody()}
        else if elementName == "joy_p" {_body = ObjBody()}
        else if elementName == "joy_m" {_body = ObjBody()}
        else if elementName == "admiration_p" {_body = ObjBody()}
        else if elementName == "admiration_m" {_body = ObjBody()}
        else if elementName == "peace_p" {_body = ObjBody()}
        else if elementName == "peace_m" {_body = ObjBody()}
        else if elementName == "ecstasy_p" {_body = ObjBody()}
        else if elementName == "ecstasy_m" {_body = ObjBody()}
        else if elementName == "amazement_p" {_body = ObjBody()}
        else if elementName == "amazement_m" {_body = ObjBody()}
        else if elementName == "rage_p" {_body = ObjBody()}
        else if elementName == "rage_m" {_body = ObjBody()}
        else if elementName == "interest_p" {_body = ObjBody()}
        else if elementName == "interest_m" {_body = ObjBody()}
        else if elementName == "respect_p" {_body = ObjBody()}
        else if elementName == "respect_m" {_body = ObjBody()}
        else if elementName == "calmly_p" {_body = ObjBody()}
        else if elementName == "calmly_m" {_body = ObjBody()}
        else if elementName == "proud_p" {_body = ObjBody()}
        else if elementName == "proud_m" {_body = ObjBody()}
        else if elementName == "batteryHi" {_body = ObjBody()}
        else if elementName == "batteryMid" {_body = ObjBody()}
        else if elementName == "batteryLow" {_body = ObjBody()}
    }
}