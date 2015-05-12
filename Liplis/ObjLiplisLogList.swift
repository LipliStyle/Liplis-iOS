//
//  ObjLiplisLogList.swift
//  Liplis
//
//  Created by sachin on 2015/04/17.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class ObjLiplisLogList {
    ///=============================
    /// プロパティ
    var logList : Array<ObjLiplisLog> = []
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
        コンストラクター
    */
    init()
    {
        logList = Array<ObjLiplisLog>()
    }
    
    /**
        ログアペンド
    */
    func append(log : String, url : String)
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
        logList.append(ObjLiplisLog(log: log,url: url,type: type))
        
        //１００件以上あった場合、最初のデータを削除する
        if logList.count > 100
        {
            logList.dequeue()
        }
    }
    func append(log : String, url : String, type : Int)
    {
        //ログ追加
        logList.append(ObjLiplisLog(log: log,url: url,type: type))
        
        //１００件以上あった場合、最初のデータを削除する
        if logList.count > 100
        {
            logList.dequeue()
        }
    }
    
    /**
        一件のlogを取得する
    */
    func getLog(idx : Int)->ObjLiplisLog    {
        return logList[idx]
    }
    
}