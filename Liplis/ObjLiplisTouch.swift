//
//  ObjLiplisTouch.swift
//  Liplis
//
//  タッチ設定管理クラス
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
class ObjLiplisTouch : NSObject, NSXMLParserDelegate {
    ///==========================
    /// 内容
    internal var touchDefList : Array<ObjTouch>!
    
    ///==========================
    /// タッチおしゃべり中
    internal var touchChatting : Bool! = false;
    
    ///==========================
    /// フラグ
    internal var checkFlg : Bool! = false;
    
    ///===========================================
    /// スキンファイル読み込み完了フラグ
    internal var loadDefault : Bool! = false
        
    //=================================
    //XML操作一時変数
    internal var _ParseKey: String! = ""
    internal var _touch : ObjTouch!
    
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
        
        self.initList()
        
        //ロードXML
        self.loadXml(url)
    }
    
    /**
        リストの初期化
    */
    internal func initList()
    {
        self.touchDefList = Array<ObjTouch>()
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
        _ParseKey = elementName
        if elementName == "touchDiscription" {_touch = ObjTouch()}
    }
    
    /**
    タグの最後で呼ばれる
    */
    internal func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "touchDiscription" {touchDefList.append(_touch)}
        self._ParseKey = ""
    }
    
    /**
    パースする。
    */
    internal func parser(parser: NSXMLParser, foundCharacters value: String?)
    {
        if (self._ParseKey == "name") {
            self._touch!.name = value!
        } else if (self._ParseKey == "type") {
            self._touch!.type = value!.toInt()
        } else if (self._ParseKey == "sens") {
            self._touch!.sens = value!.toInt()
        } else if (self._ParseKey == "top") {
            self._touch!.top = value!.toInt()
        } else if (self._ParseKey == "left") {
            self._touch!.left = value!.toInt()
        } else if (self._ParseKey == "bottom") {
            self._touch!.bottom = value!.toInt()
        } else if (self._ParseKey == "right") {
            self._touch!.right = value!.toInt()
        } else if (self._ParseKey == "chat") {
            self._touch!.setChat(value!)
        } else {
            // nop
        }
    }

    /// <summary>
    /// タッチチェック
    /// </summary>
    /// <returns></returns>
    internal func checkTouch(x : Int, y : Int, checkList : Array<String> )->ObjTouchResult
    {
        var result : ObjTouchResult = ObjTouchResult(obj: nil)
        
        for msg in self.touchDefList
        {
            if !checkListContains(msg.name,checkList: checkList)
            {
                continue
            }
        
            if msg.sens == 0
            {
                continue
            }
        
            var res : Int = msg.checkTouch(x, y: y)
        
            if (res == 2)
            {
                result.result = 2
                result.obj = msg
            
                return result
            }
            else if (res == 1)
            {
                result.result = 1
            }
        }
        
        return result;
    }
    
    /// <summary>
    /// クリックチェック
    /// </summary>
    /// <returns></returns>
    internal func checkClick(x : Int, y : Int, checkList : Array<String>, mode : Int)->ObjTouchResult
    {
        var result : ObjTouchResult = ObjTouchResult(obj: nil)
        
        for msg in self.touchDefList
        {
            if !checkListContains(msg.name,checkList: checkList)
            {
                continue
            }
        
            if mode == msg.type
            {
                result.result = mode
                if (msg.checkClick(x, y: y))
                {
                    result.obj = msg
                    return result
                }
            }
        }
        
        return result
    }
    
    
    internal func checkListContains(target : String, checkList : Array<String>) -> Bool
    {
        for item : String in checkList
        {
            if String(item) == String(target)
            {
                return true
            }
        }
        return false
    }
    
    
}