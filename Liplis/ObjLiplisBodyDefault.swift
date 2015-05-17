//
//  ObjLiplisBodyChar.swift
//  Liplis
//
//  立ち絵管理クラス(デフォリリバージョン)
//  body.xmlのインスタンス
//
//アップデート履歴
//   2015/05/05 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0 swift1.2対応
//
//  Created by sachin on 2015/05/05.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit

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
        self.initList()
        
        //スリープ画像の初期化
        self.initSleep()
        
        //プロパティの初期化
        self.initProperty()
        
        //ロードXML
        self.loadXml(url)
        
        //アスペクト比算出
        self.culcAspectRatio()
    }
    
    /**
    おやすみ画像のセット
    */
    override func initSleep()
    {
        self.sleep = UIImage(named: self.SLEEP_FILE_NAME)
    }
    
    /**
    ノーマルグラフィックを取得する
    */
    override func getNormalGraphic()->UIImage
    {
        return self.normalList[0].getLiplisBodyImgIdInsDefault(0,mouthState: 0)
    }
    
    /**
    タグの読み始めに呼ばれる
    */
    override func parser(parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI : String?,
        qualifiedName qName: String?,
        attributes attributeDict: [NSObject : AnyObject])

    {
        _ParseKey = elementName
        
        if elementName == "normal"              {self._body = ObjBody()}
        else if elementName == "joy_p"          {self._body = ObjBody()}
        else if elementName == "joy_m"          {self._body = ObjBody()}
        else if elementName == "admiration_p"   {self._body = ObjBody()}
        else if elementName == "admiration_m"   {self._body = ObjBody()}
        else if elementName == "peace_p"        {self._body = ObjBody()}
        else if elementName == "peace_m"        {self._body = ObjBody()}
        else if elementName == "ecstasy_p"      {self._body = ObjBody()}
        else if elementName == "ecstasy_m"      {self._body = ObjBody()}
        else if elementName == "amazement_p"    {self._body = ObjBody()}
        else if elementName == "amazement_m"    {self._body = ObjBody()}
        else if elementName == "rage_p"         {self._body = ObjBody()}
        else if elementName == "rage_m"         {self._body = ObjBody()}
        else if elementName == "interest_p"     {self._body = ObjBody()}
        else if elementName == "interest_m"     {self._body = ObjBody()}
        else if elementName == "respect_p"      {self._body = ObjBody()}
        else if elementName == "respect_m"      {self._body = ObjBody()}
        else if elementName == "calmly_p"       {self._body = ObjBody()}
        else if elementName == "calmly_m"       {self._body = ObjBody()}
        else if elementName == "proud_p"        {self._body = ObjBody()}
        else if elementName == "proud_m"        {self._body = ObjBody()}
        else if elementName == "batteryHi"      {self._body = ObjBody()}
        else if elementName == "batteryMid"     {self._body = ObjBody()}
        else if elementName == "batteryLow"     {self._body = ObjBody()}
    }
}