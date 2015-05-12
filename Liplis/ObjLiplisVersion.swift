//
//  ObjLiplisVersion.swift
//  Liplis
//
//  Created by sachin on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjLiplisVersion : NSObject, NSXMLParserDelegate {
    ///=============================
    /// プロパティ
    var skinVersion : String! = ""
    var liplisMiniVersion : String! = ""
    var url : String! = ""
    var apkUrl : String! = ""
    var flgCheckOn : Bool = false
    
    //=================================
    //XML操作一時変数
    var _ParseKey: String! = ""
    var _Value: String! = ""
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    init(url : NSURL)
    {
        self.skinVersion = ""
        self.liplisMiniVersion = ""
        self.url = ""
        self.apkUrl = ""
        self.flgCheckOn = false
        
        //スーパークラスのイニット
        super.init()
        
        //ロードXML
        loadXml(url)
    }
    
    func getFlgCheckOn()->Bool
    {
        return self.flgCheckOn
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
    }
    
    /**
    タグの最後で呼ばれる
    */
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (_ParseKey == "skinVersion") {
            self.skinVersion = _Value!
        } else if (_ParseKey == "liplisMiniVersion") {
            self.liplisMiniVersion = _Value!
        } else if (_ParseKey == "url") {
            self.url = _Value!
        } else if (_ParseKey == "apkUrl") {
            self.apkUrl = _Value!
        } else {
            // nop
        }
        
        //エレメント初期化
        _ParseKey = ""
        _Value = ""
    }
    
    /**
    パースする。
    */
    func parser(parser: NSXMLParser!, foundCharacters value: String!)
    {
        if (_ParseKey == "skinVersion") {
            _Value = _Value + value!
        } else if (_ParseKey == "liplisMiniVersion") {
            _Value = _Value + value!
        } else if (_ParseKey == "url") {
            _Value = _Value + value!
        } else if (_ParseKey == "apkUrl") {
            _Value = _Value + value!
        } else {
            // nop
        }
    }

}