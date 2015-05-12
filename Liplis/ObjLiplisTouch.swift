//
//  ObjLiplisTouch.swift
//  Liplis
//
//  Created by sachin on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjLiplisTouch : NSObject, NSXMLParserDelegate {
    ///==========================
    /// 内容
    var touchDefList : Array<ObjTouch>!
    
    ///==========================
    /// タッチおしゃべり中
    var touchChatting : Bool! = false;
    
    ///==========================
    /// フラグ
    var checkFlg : Bool! = false;
    
    ///===========================================
    /// スキンファイル読み込み完了フラグ
    var loadDefault : Bool! = false
        
    //=================================
    //XML操作一時変数
    var _ParseKey: String! = ""
    var _touch : ObjTouch!
    
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
        
        initList()
        
        //ロードXML
        loadXml(url)
    }
    
    /**
        リストの初期化
    */
    func initList()
    {
        touchDefList = Array<ObjTouch>()
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
        _ParseKey = elementName
        if elementName == "touchDiscription" {_touch = ObjTouch()}
    }
    
    /**
    タグの最後で呼ばれる
    */
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if elementName == "touchDiscription" {touchDefList.append(_touch)}
        _ParseKey = ""
    }
    
    /**
    パースする。
    */
    func parser(parser: NSXMLParser!, foundCharacters value: String!)
    {
        if (_ParseKey == "name") {
            _touch!.name = value!
        } else if (_ParseKey == "type") {
            _touch!.type = value!.toInt()
        } else if (_ParseKey == "sens") {
            _touch!.sens = value!.toInt()
        } else if (_ParseKey == "top") {
            _touch!.top = value!.toInt()
        } else if (_ParseKey == "left") {
            _touch!.left = value!.toInt()
        } else if (_ParseKey == "bottom") {
            _touch!.bottom = value!.toInt()
        } else if (_ParseKey == "right") {
            _touch!.right = value!.toInt()
        } else if (_ParseKey == "chat") {
            _touch!.setChat(value!)
        } else {
            // nop
        }
    }

    /// <summary>
    /// タッチチェック
    /// </summary>
    /// <returns></returns>
    func checkTouch(x : Int, y : Int, checkList : Array<String> )->ObjTouchResult
    {
        var result : ObjTouchResult = ObjTouchResult(obj: nil)
        
        for msg in touchDefList
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
    func checkClick(x : Int, y : Int, checkList : Array<String>, mode : Int)->ObjTouchResult
    {
        var result : ObjTouchResult = ObjTouchResult(obj: nil)
        
        for msg in touchDefList
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
    
    
    func checkListContains(target : String, checkList : Array<String>) -> Bool
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