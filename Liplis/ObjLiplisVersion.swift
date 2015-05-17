//
//  ObjLiplisVersion.swift
//  Liplis
//
//  バージョン管理クラス
//  touch.xmlのインスタンス
//
//アップデート履歴
//   2015/04/16 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0 リファクタリング
//
//  Created by sachin on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjLiplisVersion : NSObject, NSXMLParserDelegate {
    ///=============================
    /// プロパティ
    internal var skinVersion : String! = ""
    internal var liplisMiniVersion : String! = ""
    internal var url : String! = ""
    internal var apkUrl : String! = ""
    internal var flgCheckOn : Bool = false
    
    //=================================
    //XML操作一時変数
    internal var _ParseKey: String! = ""
    internal var _Value: String! = ""
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    internal init(url : NSURL)
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
    
    internal func getFlgCheckOn()->Bool
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
    internal func loadXml(url : NSURL)
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
        namespaceURI : String?,
        qualifiedName qName: String?,
        attributes attributeDict: [NSObject : AnyObject])
    {
        //エレメント取得
        self._ParseKey = elementName
    }
    
    /**
    タグの最後で呼ばれる
    */
    internal func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (self._ParseKey == "skinVersion") {
            self.skinVersion = self._Value!
        } else if (self._ParseKey == "liplisMiniVersion") {
            self.liplisMiniVersion = self._Value!
        } else if (self._ParseKey == "url") {
            self.url = _Value!
        } else if (self._ParseKey == "apkUrl") {
            self.apkUrl = self._Value!
        } else {
            // nop
        }
        
        //エレメント初期化
        self._ParseKey = ""
        self._Value = ""
    }
    
    /**
    パースする。
    */
    internal func parser(parser: NSXMLParser, foundCharacters value: String?)
    {
        if (self._ParseKey == "skinVersion") {
            self._Value = self._Value + value!
        } else if (self._ParseKey == "liplisMiniVersion") {
            self._Value = self._Value + value!
        } else if (self._ParseKey == "url") {
            self._Value = self._Value + value!
        } else if (self._ParseKey == "apkUrl") {
            self._Value = self._Value + value!
        } else {
            // nop
        }
    }

}