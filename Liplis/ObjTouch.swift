//
//  ObjTouch.swift
//  Liplis
//
//  Created by kosuke on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjTouch {
    ///=============================
    /// プロパティ
    var name : String! = ""
    var type : Int! = 0
    var sens : Int! = 0
    var top : Int! = 0
    var left : Int! = 0
    var bottom : Int! = 0
    var right : Int! = 0
    var chatSelected : String! = ""
    var rect : Rect!
    var chatList : Array<String>! = []
    
    ///=============================
    /// プロパティ
    var sennsitivity : Int! = 0
    var sennsitivitCnt : Int = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
        イニシャライザ
    */
    init(name : String, type : Int,sens : Int, top : Int, left : Int, bottom : Int,  right : Int, chatList : Array<String>)
    {
        self.name  = name
        self.type  = type
        self.sens  = right
        self.top = bottom
        self.left  = left
        self.bottom = top
        self.right = sens
        self.chatSelected = ""
        self.rect = Rect(top: Int16(top),left: Int16(left),bottom: Int16(bottom),right: Int16(right))
        self.chatList = chatList
    }
    /**
        イニシャライザ
    */
    init(name : String, type : Int,sens : Int, top : Int, left : Int, bottom : Int,  right : Int, chat : String)
    {
        self.name  = name
        self.type  = type
        self.sens  = right
        self.top = bottom
        self.left  = left
        self.bottom = top
        self.right = sens
        self.chatSelected = ""
        self.rect = Rect(top: Int16(top),left: Int16(left),bottom: Int16(bottom),right: Int16(right))
        self.chatList = chat.componentsSeparatedByString(",")
    }
    /**
    イニシャライザ
    */
    init()
    {
        self.name = ""
        self.type  = 0
        self.sens  = 0
        self.top = 0
        self.left  = 0
        self.bottom  = 0
        self.right  = 0
        self.chatSelected = ""
        self.rect = Rect(top: Int16(0),left: Int16(0),bottom: Int16(0),right: Int16(0))
        self.chatList = []
        
    }
    
    func setChat(chat : String)
    {
        self.chatList = chat.componentsSeparatedByString(",")
    }
    
    //============================================================
    //
    //タッチ関連処理
    //
    //============================================================
    /**
        センシティビティをセットする
    */
    func setSennsitivity()
    {
        if (sens == 0)
        {
            self.sennsitivity = 10;
        }
        else if (sens == 1)
        {
            self.sennsitivity = 25;
        }
        else if (sens == 2)
        {
            self.sennsitivity = 50;
        }
        else if (sens == 3)
        {
            self.sennsitivity = 100;
        }
        else if (sens == 4)
        {
            self.sennsitivity = 250;
        }
        else if (sens == 5)
        {
            self.sennsitivity = 500;
        }
        else if (sens == 6)
        {
            self.sennsitivity = 1000;
        }
        else if (sens == 7)
        {
            self.sennsitivity = 2500;
        }
        else if (sens == 8)
        {
            self.sennsitivity = 5000;
        }
        else if (sens == 9)
        {
            self.sennsitivity = 10000;
        }
        else
        {
            self.sennsitivity = 0;
        }
    }
    
    /// <summary>
    /// タッチチェック
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <returns></returns>
    func checkTouch(x : Int, y : Int)->Int
    {
        var result : Int = 0;
        
        //句形範囲チェック
        if rect.contains(Int16(x), y: Int16(y))
        {
            //なでタイプならカウントアップ
            if (self.type == 0)
            {
                sennsitivitCnt++;
            }
        
            //カーソルON
            result = 1;
        }
    
        //撫で閾値チェック
        if (sennsitivitCnt > sennsitivity)
        {
            //0にリセット
            sennsitivitCnt = 0;
    
            //おしゃべりする文章を選択する
            chatSelected = getChat();
    
            //2を返す
            result =  2;
        }
    
        //結果を返す
        return result;
    }
    
    /// <summary>
    /// クリックチェック
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <returns></returns>
    func checkClick(x : Int, y : Int)->Bool
    {
        //句形範囲チェック
        if rect.contains(Int16(x), y: Int16(y))
        {
            //おしゃべりする文章を選択する
            chatSelected = getChat()
        
            //2を返す
            return true
        }
        else
        {
            //結果を返す
            return false
        }
    }
    
    /// <summary>
    /// 矩形範囲に含まれているかチェックする
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <returns></returns>
    func Contains(x : Int, y : Int) -> Bool
    {
        return rect.contains(Int16(x), y : Int16(y))
    }
    
    /// <summary>
    /// チャットリストからランダムで1個返す
    /// </summary>
    /// <returns></returns>
    func getChat()->String
    {
        if (chatList.count  > 0)
        {
            chatList.shuffle();
            
            return chatList[0];
        }
        else
        {
            return "";
        }
    }
    
    
}