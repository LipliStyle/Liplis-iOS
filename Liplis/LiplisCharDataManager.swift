//
//  LiplisCharDataManager.swift
//  Liplis
//
//  キャラクターマネージャー
//  キャラクターのスキンデータを管理するクラス
//  キャラクター選択画面に表示するデータ、ウィジェットを作成する時のベースデータもここから取得する。
//
//
//アップデート履歴
//   2015/04/11 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/14 ver1.3.0 キャラクターを削除した場合、キャラクターリストが正しく更新されなかった問題修正
//
//  Created by sachin on 2015/05/01.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class LiplisCharDataManager
{
    ///=============================
    /// プロパティ
    internal var skinDataList : Array<LiplisSkinData>! = []      //スキンデータリスト
    private var preListCnt : Int! = 0                           //前回リストカウント値
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    デフォルトイニシャライザ
    */
    internal init()
    {
        //スキンデータリストの初期化
        initSkinDataList()
    }
    
    /**
    スキンデータリストの初期化
    */
    private func initSkinDataList()
    {
        //スキンリストの初期化
        self.skinDataList = Array<LiplisSkinData>()
        
        //デフォルトリリのデータを追加する
        self.skinDataList.append(LiplisSkinData())
        
        //ドキュメントルートにあるディレクトリのリストを取得する
        var documentRoot : String = LiplisFileManager.getDocumentRoot()
        var rootDirList : Array<String> = LiplisFileManager.getFileNamesDocumentPath()
        
        //回して、skin.xmlを探す
        for dirName in rootDirList
        {
            //スキンフォルダの中のファイルリストを取得する
            var fileList : Array<String>! = LiplisFileManager.contentsOfDirectoryAtPath(documentRoot + "/" + dirName)
            
            //nilなら、ディレクトリではないので、スルー
            if fileList == nil
            {
                
            }
            else
            {
                //nilでなければ、ディレクトリなので、skin.xmlを探す。
                for fileName in fileList
                {
                    //skin.xmlが見つかった
                    if fileName == "skin.xml"
                    {
                        self.skinDataList.append(LiplisSkinData(charName: dirName))
                    }
                }
            }
        }
        
        //前回カウント値取得(単純にスキンデータリストのカウントを取るとデフォリリの分ずれるので、1引く)
        self.preListCnt = self.skinDataList.count - 1
    }
    
    //============================================================
    //
    //再ロード
    //
    //============================================================
    
    /**
    スキンデータリストの再読み込み
    */
    internal func skinDataListReload()
    {
        //前回スキン取得時と数が異なっていたら、リロードする
        if self.preListCnt != self.getCharNameList().count
        {
            //スキンリストのリロード
            initSkinDataList()
        }
    }
    
    /**
    現在共有フォルダにあるスキンのキャラクターリストを取得する
    */
    internal func getCharNameList()->Array<String>
    {
        var charNameList : Array<String> = Array<String>()
        
        //ドキュメントルートにあるディレクトリのリストを取得する
        var documentRoot : String = LiplisFileManager.getDocumentRoot()
        var rootDirList : Array<String> = LiplisFileManager.getFileNamesDocumentPath()
        
        //回して、skin.xmlを探す
        for dirName in rootDirList
        {
            //スキンフォルダの中のファイルリストを取得する
            var fileList : Array<String>! = LiplisFileManager.contentsOfDirectoryAtPath(documentRoot + "/" + dirName)
            
            //nilなら、ディレクトリではないので、スルー
            if fileList == nil
            {
                
            }
            else
            {
                //nilでなければ、ディレクトリなので、skin.xmlを探す。
                for fileName in fileList
                {
                    //skin.xmlが見つかった
                    if fileName == "skin.xml"
                    {
                        charNameList.append(dirName)
                    }
                }
            }
        }
        
        return charNameList
    }
    
    //============================================================
    //
    //LiplisSkinData取得処理
    //
    //============================================================
    
    /**
    名前指定でLiplisSkinDataを取得する
    */
    internal func getLiplisSkinData(charDefine : String)->LiplisSkinData!
    {
        for lsd in skinDataList
        {
            if lsd.charDefine == charDefine
            {
                return lsd
            }
        }
        
        return nil
    }
    
    
    
}