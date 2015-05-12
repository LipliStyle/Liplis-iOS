//
//  ObjBody.swift
//  Liplis
//
//  Created by sachin on 2015/04/12.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit
class ObjBody {
    //=================================
    //プロパティ
    var emotion : String
    var eye_1_o : String
    var eye_1_c : String
    var eye_2_o : String
    var eye_2_c : String
    var eye_3_o : String
    var eye_3_c : String
    var bodyPath : String

    
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
    init(bodyPath : String)
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
    func getLiplisBodyId(eyeState : Int, mouthState : Int)->String
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
    
    
    
    func getLiplisBodyImgIdIns(eyeState : Int, mouthState : Int)->UIImage
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
    
    func getLiplisBodyImgIdInsDefault(eyeState : Int, mouthState : Int)->UIImage
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