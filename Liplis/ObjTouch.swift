//
//  ObjTouch.swift
//  Liplis
//
//  タッチ情報インスタンス
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
import UIKit
import Foundation
class ObjTouch {
    ///=============================
    /// プロパティ
    internal var name : String! = ""
    internal var type : Int! = 0
    internal var sens : Int! = 0
    internal var top : Int! = 0
    internal var left : Int! = 0
    internal var bottom : Int! = 0
    internal var right : Int! = 0
    internal var chatSelected : String! = ""
    internal var rect : CGRect!
    internal var chatList : Array<String>! = []
    
    ///=============================
    /// プロパティ
    internal var sennsitivity : Int! = 0
    internal var sennsitivitCnt : Int = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
        イニシャライザ
    */
    internal init(name : String, type : Int,sens : Int, top : Int, left : Int, bottom : Int,  right : Int, chatList : Array<String>)
    {
        self.name  = name
        self.type  = type
        self.sens  = right
        self.top = bottom
        self.left  = left
        self.bottom = top
        self.right = sens
        self.chatSelected = ""
        self.rect = CGRect(origin: CGPoint(x: top,y: left), size: CGSize(width: bottom,height: right))
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
        self.rect = CGRect(origin: CGPoint(x: top,y: left), size: CGSize(width: bottom,height: right))
        self.chatList = chat.componentsSeparatedByString(",")
    }
    /**
    イニシャライザ
    */
    internal init()
    {
        self.name = ""
        self.type  = 0
        self.sens  = 0
        self.top = 0
        self.left  = 0
        self.bottom  = 0
        self.right  = 0
        self.chatSelected = ""
        self.rect = CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: 0,height: 0))
        self.chatList = []
        
    }
    
    /**
    設定をチャットリストに追加する
    */
    internal func setChat(chat : String)
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
    internal func setSennsitivity()
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
    internal func checkTouch(x : Int, y : Int)->Int
    {
        var result : Int = 0;
        
        //句形範囲チェック
        if rect.contains(Int16(x), y: Int16(y))
        {
            //なでタイプならカウントアップ
            if (self.type == 0)
            {
                self.sennsitivitCnt++;
            }
        
            //カーソルON
            result = 1;
        }
    
        //撫で閾値チェック
        if (self.sennsitivitCnt > self.sennsitivity)
        {
            //0にリセット
            self.sennsitivitCnt = 0;
    
            //おしゃべりする文章を選択する
            self.chatSelected = getChat();
    
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
    internal func checkClick(x : Int, y : Int)->Bool
    {
        //句形範囲チェック
        if rect.contains(Int16(x), y: Int16(y))
        {
            //おしゃべりする文章を選択する
            self.chatSelected = self.getChat()
        
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
    internal func Contains(x : Int, y : Int) -> Bool
    {
        return rect.contains(Int16(x), y : Int16(y))
    }
    
    /// <summary>
    /// チャットリストからランダムで1個返す
    /// </summary>
    /// <returns></returns>
    internal func getChat()->String
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