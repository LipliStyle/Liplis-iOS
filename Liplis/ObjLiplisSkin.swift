//
//  ObjLiplisSkin.swift
//  Liplis
//
//  Created by sachin on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
import Foundation
class ObjLiplisSkin : NSObject, NSXMLParserDelegate {
    ///=============================
    /// プロパティ
    var charName : String = ""
    var textFont : String = ""
    var textColor : String = ""
    var linkColor : String = ""
    var titleColor : String = ""
    var themaColor : String = ""
    var themaColor2 : String = ""
    var charIntroduction : String = ""
    var version : String = ""
    var tone : String = ""
    
    //=================================
    //XML操作一時変数
    var _ParseKey: String! = ""
    var _ParseProperty : NSDictionary!
    var _Value: String! = ""
    
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
        super.init()
        
        //ロードXML
        loadXml(url)
    }
    
    
    //============================================================
    //
    //XMLロード
    //
    //============================================================
    
    /**
    XMLのロード
    */
    func loadXml(url : NSURL)
    {
        var parser : NSXMLParser? = NSXMLParser(contentsOfURL: url)
        if parser != nil
        {
            parser!.delegate = self
            parser!.parse()
        }
        else
        {
        }
    }
    /**
    XMLのロード
    リプリスにロードしたとき、必ずアイコンロードを行うこと！
    */
//    func loadXml(filePath : String)
//    {
//        var parser : NSXMLParser? = NSXMLParser(contentsOfFile: filePath)
//        if parser != nil
//        {
//            parser!.delegate = self
//            parser!.parse()
//        }
//        else
//        {
//        }
//    }
    
    /**
    読み込み開始処理完了時処理
    */
    func parserDidStartDocument(parser: NSXMLParser!)
    {
        //結果格納リストの初期化(イニシャラいざで初期化しているので省略)
    }
    
    /**
    更新処理
    */
    func parserDidEndDocument(parser: NSXMLParser!)
    {
        // 画面など、他オブジェクトを更新する必要がある場合はここに記述する(必要ないので省略)
    }
    
    /**
    タグの読み始めに呼ばれる
    */
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!)
    {
        //エレメント取得
        _ParseKey = elementName
        _ParseProperty = attributeDict
    }
    
    /**
    タグの最後で呼ばれる
    */
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        var key : String = ""
        var value : String = ""
        
        //NULLチェック
        if _ParseProperty != nil
        {
            key = _ParseProperty["key"] as String
            value = _ParseProperty["value"] as String
        }
 
        if (_ParseKey == "add") {
            if(key == "charName")
            {
                self.charName = value
            }
            else if(key == "textFont")
            {
                self.textFont = value
            }
            else if(key == "textColor")
            {
                self.textColor  = value
            }
            else if(key == "linkColor")
            {
                self.linkColor = value
            }
            else if(key == "titleColor")
            {
                self.titleColor = value
            }
            else if(key == "themaColor")
            {
                self.themaColor = value
            }
            else if(key == "themaColor2")
            {
                self.themaColor2  = value
            }
            else if(key == "charIntroduction")
            {
                self.charIntroduction  = value
            }
            else if(key == "version")
            {
                self.version  = value
            }
            else if(key == "tone")
            {
                self.tone  = value
            }
        } else {
            // nop
        }
        
        //エレメント初期化
        _ParseKey = ""
        _ParseProperty = nil
        _Value = ""
    }
    
    /**
    パースする。
    */
    func parser(parser: NSXMLParser!, foundCharacters value: String!)
    {
//        if (_ParseKey == "add") {
//            _Value = _Value + value!
//        } else {
//            // nop
//        }
    }
    
    
}