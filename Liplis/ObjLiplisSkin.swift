//
//  ObjLiplisSkin.swift
//  Liplis
//
//  スキン設定管理クラス
//  skin.xmlのインスタンス
//
//アップデート履歴
//   2015/04/16 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0 Calendarの表記をSwift1.2.対応
//
//  Created by sachin on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
import Foundation
class ObjLiplisSkin : NSObject, NSXMLParserDelegate {
    ///=============================
    /// プロパティ
    internal var charName : String = ""
    internal var textFont : String = ""
    internal var textColor : String = ""
    internal var linkColor : String = ""
    internal var titleColor : String = ""
    internal var themaColor : String = ""
    internal var themaColor2 : String = ""
    internal var charIntroduction : String = ""
    internal var version : String = ""
    internal var tone : String = ""
    
    //=================================
    //XML操作一時変数
    internal var _ParseKey: String! = ""
    internal var _ParseProperty : NSDictionary!
    internal var _Value: String! = ""
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    デフォルトイニシャライザ
    */
    internal init(url : NSURL)
    {
        super.init()
        
        //ロードXML
        self.loadXml(url)
    }
    
    
    //============================================================
    //
    //XMLロード
    //
    //============================================================
    
    /**
    XMLのロード
    */
    internal func loadXml(url : NSURL)
    {
        let parser : NSXMLParser? = NSXMLParser(contentsOfURL: url)
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
    internal func parserDidStartDocument(parser: NSXMLParser)
    {
        //結果格納リストの初期化(イニシャラいざで初期化しているので省略)
    }
    
    /**
    更新処理
    */
    internal func parserDidEndDocument(parser: NSXMLParser)
    {
        // 画面など、他オブジェクトを更新する必要がある場合はここに記述する(必要ないので省略)
    }
    
    /**
    タグの読み始めに呼ばれる
    */
    internal func parser(parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String])
    {
        //エレメント取得
        self._ParseKey = elementName
        self._ParseProperty = attributeDict
    }
    
    /**
    タグの最後で呼ばれる
    */
    internal func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        var key : String = ""
        var value : String = ""
        
        //NULLチェック
        if _ParseProperty != nil
        {
            key = _ParseProperty["key"] as! String
            value = _ParseProperty["value"]as! String
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
    internal func parser(parser: NSXMLParser,foundCharacters value: String)    {
//        if (_ParseKey == "add") {
//            _Value = _Value + value!
//        } else {
//            // nop
//        }
    }
    
    
}