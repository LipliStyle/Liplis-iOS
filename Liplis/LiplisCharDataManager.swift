//
//  CharDataManager.swift
//  Liplis
//
//  Created by sachin on 2015/05/01.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class LiplisCharDataManager
{
    ///=============================
    /// プロパティ
    var skinDataList : Array<LiplisSkinData>! = []
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    デフォルトイニシャライザ
    */
    init()
    {
        //スキンデータリストの初期化
        initSkinDataList()
    }
    
    /**
    スキンデータリストの初期化
    */
    func initSkinDataList()
    {
        //スキンリストの初期化
        skinDataList = Array<LiplisSkinData>()
        
        //デフォルトリリのデータを追加する
        skinDataList.append(LiplisSkinData())
        
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
                        skinDataList.append(LiplisSkinData(charName: dirName))
                    }
                }
            }
        }
    }
    
    //============================================================
    //
    //再ロード
    //
    //============================================================
    
    /**
    スキンデータリストの再読み込み
    */
    func skinDataListReload()
    {
        //キャラクターデータリストを取得する
        var charNameDocumentList : Array<String> = getCharNameList()
        var hit : Bool = false
        
        //比較して、実データリストを回し、読み込みデータを検索し、HITしなければ見読み込みなので追加する。
        for chardoc in charNameDocumentList
        {
            hit = false
            
            for skindata : LiplisSkinData in skinDataList
            {
                if(chardoc == skindata.charName)
                {
                    hit = true
                }
            }
            
            //見読み込み。追加
            if !hit
            {
                skinDataList.append(LiplisSkinData(charName: chardoc))
            }
        }
        
        //比較して、読み込みデータを回し、実データリストを検索し、HITしなければ削除されたデータなので削除する。
        var idx : Int = 0
        for skindata : LiplisSkinData in skinDataList
        {
            hit = false
            
            if skindata.charDefine != LiplisDefine.SKIN_NAME_DEFAULT
            {
                for chardoc in charNameDocumentList
                {
                    if(chardoc == skindata.charName)
                    {
                        hit = true
                    }
                }
                
                //見読み込み。追加
                if !hit
                {
                    skinDataList.removeAtIndex(idx)
                }
            }

            
            idx++
        }
    }
    
    /**
    現在共有フォルダにあるスキンのキャラクターリストを取得する
    */
    func getCharNameList()->Array<String>
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
    func getLiplisSkinData(charDefine : String)->LiplisSkinData!
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