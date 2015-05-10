//
//  LiplisFileManager.swift
//  Liplis
//
//  Created by kosuke on 2015/05/03.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
struct LiplisFileManager
{
    /**
    指定のフォルダにある全てのファイルを取得する
    */
    static func getAllFileNamesFromDocumentPath(path: String) -> Array<String>
    {
        //初期リスト
        var resList : Array<String> = []
        
        //結果を返す
        return getAllFileNamesFromTargetPath(path,inList: resList)
    }
    static func getAllFileNamesFromTargetPath(path: String, inList : Array<String>) -> Array<String>
    {
        //指定パスのファイル/ディレクトリのリスト
        var contents : Array<String>! = contentsOfDirectoryAtPath(path)
        
        //バッファリスト作成
        var resList : Array<String> = []
        
        //親リスト追加
        resList.addRange(inList)
        
        //ファイルなら、コンテンツがnilとなる
        if contents == nil
        {
            //ファイルパスを設定して返す
            resList.append(path)
            return resList
        }
        else
        {
            //再帰的にファイルを取り出す
            for p in contents
            {
                resList = getAllFileNamesFromTargetPath(path + "/" + p,inList: resList)
            }
        }
        
        return resList
    }
    
    /**
    ドキュメントパスにある全てのファイルを取得する(サブフォルダも含めて全て取得)
    */
    static func getAllFileNamesFromDocumentPath() -> Array<String>
    {
        //ドキュメントパスの取得
        let documentsPath = getDocumentRoot()
        //結果を返す
        return getAllFileNamesFromDocumentPath(documentsPath)
    }
    
    /**
    ドキュメントパスにある全てのファイルを取得する フォルダ上のみ
    */
    static func getFileNamesDocumentPath() -> Array<String>!
    {
        return contentsOfDirectoryAtPath(getDocumentRoot())
    }
    
    /**
    指定のフォルダにある全てのファイルを取得する
    (最もプリミティブな処理)
    */
    static func contentsOfDirectoryAtPath(path: String) -> Array<String>!{
        var error: NSError? = nil
        let fileManager = NSFileManager.defaultManager()
        let contents = fileManager.contentsOfDirectoryAtPath(path, error: &error)
        if contents == nil {
            return nil
        }
        else {
            let filenames = contents as Array<String>
            return filenames
        }
    }
    
    /**
    共有フォルダのパスを返す
    */
    static func getDocumentRoot()->String
    {
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String

    }
    
    /**
    共有フォルダのURLを返す
    */
    static func getDocumentRootUrl()->NSURL
    {
        let fileManager = NSFileManager.defaultManager()
        return fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as NSURL
        
        //配下フォルダへのアクセス例
        //url2 = url.URLByAppendingPathComponent("LiliRenew/skin.xml")
    }
    
}