//
//  ObjBody.swift
//  Liplis
//
//  一つの立ち絵インスタンス(6つの画像セット)
//
//アップデート履歴
//   2015/04/12 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0 リファクタリング
//
//  Created by sachin on 2015/04/12.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit
class ObjBody {
    //=================================
    //プロパティ
    internal var emotion : String
    internal var eye_1_o : String
    internal var eye_1_c : String
    internal var eye_2_o : String
    internal var eye_2_c : String
    internal var eye_3_o : String
    internal var eye_3_c : String
    internal var bodyPath : String

    
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
        self.emotion = ""
        self.eye_1_o = ""
        self.eye_1_c = ""
        self.eye_2_o = ""
        self.eye_2_c = ""
        self.eye_3_o = ""
        self.eye_3_c = ""
        self.bodyPath = ""
    }
    
    /**
    イニシャライザ
    */
    internal init(bodyPath : String)
    {
        self.emotion = ""
        self.eye_1_o = ""
        self.eye_1_c = ""
        self.eye_2_o = ""
        self.eye_2_c = ""
        self.eye_3_o = ""
        self.eye_3_c = ""
        self.bodyPath = bodyPath
    }
    
    //============================================================
    //
    //一般処理
    //
    //============================================================
    internal func getLiplisBodyId(eyeState : Int, mouthState : Int)->String
    {
        if(mouthState == 2)
        {
            if(eyeState == 2)
            {
                return self.eye_2_c
            }
            else if(eyeState == 3)
            {
                return self.eye_3_c
            }
            else
            {
                return self.eye_1_c
            }
        }
        else
        {
            if(eyeState == 2)
            {
                return self.eye_2_o
            }
            else if(eyeState == 3)
            {
                return self.eye_3_o
            }
            else
            {
                return self.eye_1_o
            }
        }
    }
    
    
    
    internal func getLiplisBodyImgIdIns(eyeState : Int, mouthState : Int)->UIImage
    {
        if(mouthState == 2)
        {
            if(eyeState == 2)
            {
                return UIImage(contentsOfFile: bodyPath + "/" + self.eye_2_c)!
            }
            else if(eyeState == 3)
            {
                return UIImage(contentsOfFile: bodyPath + "/" + self.eye_3_c)!
            }
            else
            {
                return UIImage(contentsOfFile: bodyPath + "/" + self.eye_1_c)!
            }
        }
        else
        {
            if(eyeState == 2)
            {
                return UIImage(contentsOfFile: bodyPath + "/" + self.eye_2_o)!
            }
            else if(eyeState == 3)
            {
                return UIImage(contentsOfFile: bodyPath + "/" + self.eye_3_o)!
            }
            else
            {
                return UIImage(contentsOfFile: bodyPath + "/" + self.eye_1_o)!
            }
        }
    }
    
    internal func getLiplisBodyImgIdInsDefault(eyeState : Int, mouthState : Int)->UIImage
    {
        if(mouthState == 2)
        {
            if(eyeState == 2)
            {
                return UIImage(named: self.eye_2_c)!
            }
            else if(eyeState == 3)
            {
                return UIImage(named: self.eye_3_c)!
            }
            else
            {
                return UIImage(named: self.eye_1_c)!
            }
        }
        else
        {
            if(eyeState == 2)
            {
                return UIImage(named: self.eye_2_o)!
            }
            else if(eyeState == 3)
            {
                return UIImage(named: self.eye_3_o)!
            }
            else
            {
                return UIImage(named: self.eye_1_o)!
            }
        }
    }
}