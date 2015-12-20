//
//  LiplisFileManager.swift
//  Liplis
//
//  iOSのファイルにアクセスするためのクラス
//
//アップデート履歴
//   2015/05/03 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　リファクタリング
//
//  Created by sachin on 2015/05/03.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import Foundation

struct LiplisFileManager
{
    /**
    指定のフォルダにある全てのファイルを取得する
    */
    internal static func getAllFileNamesFromDocumentPath(path: String) -> Array<String>
    {
        //初期リスト
        let resList : Array<String> = []
        
        //結果を返す
        return getAllFileNamesFromTargetPath(path,inList: resList)
    }
    internal static func getAllFileNamesFromTargetPath(path: String, inList : Array<String>) -> Array<String>
    {
        //指定パスのファイル/ディレクトリのリスト
        let contents : Array<String>! = contentsOfDirectoryAtPath(path)
        
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
    internal static func getAllFileNamesFromDocumentPath() -> Array<String>
    {
        //ドキュメントパスの取得
        let documentsPath = getDocumentRoot()
        //結果を返す
        return getAllFileNamesFromDocumentPath(documentsPath)
    }
    
    /**
    ドキュメントパスにある全てのファイルを取得する フォルダ上のみ
    */
    internal static func getFileNamesDocumentPath() -> Array<String>!
    {
        return contentsOfDirectoryAtPath(getDocumentRoot())
    }
    
    /**
    指定のフォルダにある全てのファイルを取得する
    (最もプリミティブな処理)
    */
    internal static func contentsOfDirectoryAtPath(path: String) -> Array<String>!{
        var error: NSError? = nil
        let fileManager = NSFileManager.defaultManager()
        let contents: [AnyObject]?
        do {
            contents = try fileManager.contentsOfDirectoryAtPath(path)
        } catch let error1 as NSError {
            error = error1
            contents = nil
        }
        if contents == nil {
            return nil
        }
        else {
            let filenames = contents as! Array<String>
            return filenames
        }
    }
    
    /**
    共有フォルダのパスを返す
    */
    internal static func getDocumentRoot()->String
    {
        //共有フォルダをバックアップさせない設定
        notBackupSetting()
        
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
    }
    
    /**
    共有フォルダのURLを返す
    */
    internal static func getDocumentRootUrl()->NSURL
    {
        //共有フォルダをバックアップさせない設定
        notBackupSetting()
        
        let fileManager = NSFileManager.defaultManager()
        return fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        
        //配下フォルダへのアクセス例
        //url2 = url.URLByAppendingPathComponent("LiliRenew/skin.xml")
    }
    
    /**
    バックアップさせない設定
    */
    internal static func notBackupSetting()
    {
        let fileManager = NSFileManager.defaultManager()
        var error : NSError?
        let url : NSURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        
        do {
            //バックアップさせない！
            try url.setResourceValue(true, forKey : NSURLIsExcludedFromBackupKey)
        } catch let error1 as NSError {
            error = error1
        }
        
    }

}