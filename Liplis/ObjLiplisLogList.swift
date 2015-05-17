//
//  ObjLiplisLogList.swift
//  Liplis
//
//  ログ管理クラス
//
//アップデート履歴
//   2015/04/17 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0 リファクタリング
//
//  Created by sachin on 2015/04/17.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjLiplisLogList {
    ///=============================
    /// プロパティ
    internal var logList : Array<ObjLiplisLog> = []
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
        コンストラクター
    */
    internal init()
    {
        self.logList = Array<ObjLiplisLog>()
    }
    
    /**
        ログアペンド
    */
    internal func append(log : String, url : String)
    {
        var type : Int = 0
        
        if(url == "")
        {
            type = 0
        }
        else
        {
            type = 1
        }
        
        //ログ追加
        self.logList.append(ObjLiplisLog(log: log,url: url,type: type))
        
        //１００件以上あった場合、最初のデータを削除する
        if logList.count > 100
        {
            self.logList.dequeue()
        }
    }
    internal func append(log : String, url : String, type : Int)
    {
        //ログ追加
        self.logList.append(ObjLiplisLog(log: log,url: url,type: type))
        
        //１００件以上あった場合、最初のデータを削除する
        if logList.count > 100
        {
            self.logList.dequeue()
        }
    }
    
    /**
        一件のlogを取得する
    */
    internal func getLog(idx : Int)->ObjLiplisLog    {
        return self.logList[idx]
    }
    
}