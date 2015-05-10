//
//  ObjLiplisBody.swift
//  Liplis
//
// NSXMLParserDelegateを使うためには、NSObjectも継承する
//
//
//  Created by kosuke on 2015/04/12.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit
import Foundation

class ObjLiplisBody : NSObject, NSXMLParserDelegate {
    //=================================
    //プロパティ
    var bodyPath : String! = ""
    var height : CGFloat!
    var width : CGFloat!
    var heightReal : CGFloat!
    var widthReal : CGFloat!
    var locationX : Int!
    var locationY : Int!
    
    //=================================
    //立ち絵リスト
    var normalList : Array<ObjBody> = []
    var joy_p_List : Array<ObjBody> = []
    var joy_m_List : Array<ObjBody> = []
    var admiration_p_List : Array<ObjBody> = []
    var admiration_m_List : Array<ObjBody> = []
    var peace_p_List : Array<ObjBody> = []
    var peace_m_List : Array<ObjBody> = []
    var ecstasy_p_List : Array<ObjBody> = []
    var ecstasy_m_List : Array<ObjBody> = []
    var amazement_p_List : Array<ObjBody> = []
    var amazement_m_List : Array<ObjBody> = []
    var rage_p_List : Array<ObjBody> = []
    var rage_m_List : Array<ObjBody> = []
    var interest_p_List : Array<ObjBody> = []
    var interest_m_List : Array<ObjBody> = []
    var respect_p_List : Array<ObjBody> = []
    var respect_m_List : Array<ObjBody> = []
    var calmly_p_List : Array<ObjBody> = []
    var calmly_m_List : Array<ObjBody> = []
    var proud_p_List : Array<ObjBody> = []
    var proud_m_List : Array<ObjBody> = []
    
    var batteryHi_List : Array<ObjBody> = []
    var batteryMid_List : Array<ObjBody> = []
    var batteryLow_List : Array<ObjBody> = []
    var sleep : UIImage!
    
    //=================================
    //XML操作一時変数
    var _ParseKey: String! = ""
    var _body : ObjBody!

    //=================================
    //スリープファイル名
    let SLEEP_FILE_NAME : String = "sleep"
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
        デフォルトイニシャライザ
    */
    override init()
    {
        super.init()
    }
    
    /**
    URLイニシャライザ(デフォルト)
    */
    init(url : NSURL, bodyPath : String)
    {
        //スーパークラスのイニット
        super.init()
        
        //ボディパスの取得
        self.bodyPath = bodyPath
        
        //リストの初期化
        initList()
        
        //スリープ画像の初期化
        initSleep()
        
        //プロパティの初期化
        initProperty()
        
        //ロードXML
        loadXml(url)
        
        //アスペクト比算出
        culcAspectRatio()
    }
    
    /**
        リストの初期化
    */
    func initList()
    {
        normalList = Array<ObjBody>()
        joy_p_List = Array<ObjBody>()
        joy_m_List = Array<ObjBody>()
        admiration_p_List = Array<ObjBody>()
        admiration_m_List = Array<ObjBody>()
        peace_p_List = Array<ObjBody>()
        peace_m_List = Array<ObjBody>()
        ecstasy_p_List = Array<ObjBody>()
        ecstasy_m_List = Array<ObjBody>()
        amazement_p_List = Array<ObjBody>()
        amazement_m_List = Array<ObjBody>()
        rage_p_List = Array<ObjBody>()
        rage_m_List = Array<ObjBody>()
        interest_p_List = Array<ObjBody>()
        interest_m_List = Array<ObjBody>()
        respect_p_List = Array<ObjBody>()
        respect_m_List = Array<ObjBody>()
        calmly_p_List = Array<ObjBody>()
        calmly_m_List = Array<ObjBody>()
        proud_p_List = Array<ObjBody>()
        proud_m_List = Array<ObjBody>()
        
        batteryHi_List = Array<ObjBody>()
        batteryMid_List = Array<ObjBody>()
        batteryLow_List = Array<ObjBody>()
    }
    
    
    /**
    スリープ画像の初期化
    */
    func initSleep()
    {
        sleep = UIImage(contentsOfFile: self.bodyPath + "/sleep.png")
    }
    
    /**
    プロパティの初期化
    */
    func initProperty()
    {
        self.height = 0
        self.width = 0
        self.locationX = 0
        self.locationY = 0
    }
    
    /**
    アスペクト比の計算
    */
    func culcAspectRatio()
    {
        self.heightReal = 150       //150固定
        
        if self.height <= 0
        {
            //xmlに設定が無い場合は画像から判定する
            let img : UIImage = getNormalGraphic()
            
            self.height = img.size.height
            self.width = img.size.width
        }
        
        if self.height > 0
        {
            self.widthReal = self.heightReal * (self.width / self.height)
        }
        else
        {
            self.widthReal = 120
        }
    }
    
    func getNormalGraphic()->UIImage
    {
        return normalList[0].getLiplisBodyImgIdIns(0,mouthState: 0)
    }
    
    //============================================================
    //
    //XMLロード
    //
    //============================================================

    /**
        XMLのロード
    */
    func loadXml(url : NSURL)
    {
        var parser : NSXMLParser? = NSXMLParser(contentsOfURL: url)
        if parser != nil
        {
            parser!.delegate = self
            parser!.parse()
        }
        else
        {
            
        }
        
    }
    
    /**
        読み込み開始処理完了時処理
    */
    func parserDidStartDocument(parser: NSXMLParser!)
    {
        //結果格納リストの初期化(イニシャラいざで初期化しているので省略)
    }
    
    /**
        更新処理
    */
    func parserDidEndDocument(parser: NSXMLParser!)
    {
        // 画面など、他オブジェクトを更新する必要がある場合はここに記述する(必要ないので省略)
    }
    
    /**
        タグの読み始めに呼ばれる
    */
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!)
    {
        _ParseKey = elementName
        
        if elementName == "normal" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "joy_p" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "joy_m" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "admiration_p" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "admiration_m" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "peace_p" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "peace_m" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "ecstasy_p" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "ecstasy_m" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "amazement_p" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "amazement_m" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "rage_p" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "rage_m" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "interest_p" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "interest_m" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "respect_p" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "respect_m" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "calmly_p" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "calmly_m" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "proud_p" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "proud_m" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "batteryHi" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "batteryMid" {_body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "batteryLow" {_body = ObjBody(bodyPath: self.bodyPath)}
    }
    
    /**
        タグの最後で呼ばれる
    */
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if elementName == "normal" {normalList.append(_body)}
        else if elementName == "joy_p" {joy_p_List.append(_body)}
        else if elementName == "joy_m" {joy_m_List.append(_body)}
        else if elementName == "admiration_p" {admiration_p_List.append(_body)}
        else if elementName == "admiration_m" {admiration_m_List.append(_body)}
        else if elementName == "peace_p" {peace_p_List.append(_body)}
        else if elementName == "peace_m" {peace_m_List.append(_body)}
        else if elementName == "ecstasy_p" {ecstasy_p_List.append(_body)}
        else if elementName == "ecstasy_m" {ecstasy_m_List.append(_body)}
        else if elementName == "amazement_p" {amazement_p_List.append(_body)}
        else if elementName == "amazement_m" {amazement_m_List.append(_body)}
        else if elementName == "rage_p" {rage_p_List.append(_body)}
        else if elementName == "rage_m" {rage_m_List.append(_body)}
        else if elementName == "interest_p" {interest_p_List.append(_body)}
        else if elementName == "interest_m" {interest_m_List.append(_body)}
        else if elementName == "respect_p" {respect_p_List.append(_body)}
        else if elementName == "respect_m" {respect_m_List.append(_body)}
        else if elementName == "calmly_p" {calmly_p_List.append(_body)}
        else if elementName == "calmly_m" {calmly_m_List.append(_body)}
        else if elementName == "proud_p" {proud_p_List.append(_body)}
        else if elementName == "proud_m" {proud_m_List.append(_body)}
        else if elementName == "batteryHi" {batteryHi_List.append(_body)}
        else if elementName == "batteryMid" {batteryMid_List.append(_body)}
        else if elementName == "batteryLow" {batteryLow_List.append(_body)}
        
        _ParseKey = ""
    }
    
    /**
        パースする。
    */
    func parser(parser: NSXMLParser!, foundCharacters value: String!)
    {
        if (_ParseKey == "emotion") {
            _body!.emotion = value!
        } else if (_ParseKey.hasSuffix("11")) {
            _body!.eye_1_c = value!
        } else if (_ParseKey.hasSuffix("12")) {
            _body!.eye_1_o = value!
        } else if (_ParseKey.hasSuffix("21")) {
            _body!.eye_2_c = value!
        } else if (_ParseKey.hasSuffix("22")) {
            _body!.eye_2_o = value!
        } else if (_ParseKey.hasSuffix("31")) {
            _body!.eye_3_c = value!
        } else if (_ParseKey.hasSuffix("32")) {
            _body!.eye_3_o = value!
        } else if (_ParseKey.hasSuffix("height")) {
            self.height = CGFloat(value!.toInt()!)
        } else if (_ParseKey.hasSuffix("width")) {
            self.width = CGFloat(value!.toInt()!)
        } else if (_ParseKey.hasSuffix("locationX")) {
            self.locationX = value!.toInt()
        } else if (_ParseKey.hasSuffix("locationY")) {
            self.locationY = value!.toInt()
        } else {
            // nop
        }
    }
    
    //============================================================
    //
    //ボディ取得処理
    //
    //============================================================
    
    /**
        感情種類と感情レベルからリストを選択し、その中からボディデータを１個返す
    */
    func getLiplisBody(emotion : Int, point : Int)->ObjBody
    {
        var body : ObjBody = ObjBody()
        
        if(point > 0)
        {
            switch(emotion)
            {
                case 0:body = selectBody(normalList)
                    break
                case 1:body = selectBody(joy_p_List)
                    break
                case 2:body = selectBody(admiration_p_List)
                    break
                case 3:body = selectBody(peace_p_List)
                    break
                case 4:body = selectBody(ecstasy_p_List)
                    break
                case 5:body = selectBody(amazement_p_List)
                    break
                case 6:body = selectBody(rage_p_List)
                    break
                case 7:body = selectBody(interest_p_List)
                    break
                case 8:body = selectBody(respect_p_List)
                    break
                case 9:body = selectBody(calmly_p_List)
                    break
                case 10:body = selectBody(proud_p_List)
                    break
                default:body = selectBody(normalList)
                    break
            }
        }
        else
        {
            switch(emotion)
            {
                case 0:body = selectBody(normalList)
                    break
                case 1:body = selectBody(joy_m_List)
                    break
                case 2:body = selectBody(admiration_m_List)
                    break
                case 3:body = selectBody(peace_m_List)
                    break
                case 4:body = selectBody(ecstasy_m_List)
                    break
                case 5:body = selectBody(amazement_m_List)
                    break
                case 6:body = selectBody(rage_m_List)
                    break
                case 7:body = selectBody(interest_m_List)
                    break
                case 8:body = selectBody(respect_m_List)
                    break
                case 9:body = selectBody(calmly_m_List)
                    break
                case 10:body = selectBody(proud_m_List)
                    break
                default:body = selectBody(normalList)
                    break
            }

        }
        
        return body
    }
    
    
    func getLiplisBodyHelth(helth : Int,emotion : Int, point : Int)->ObjBody
    {
        //小破以上
        if(helth > 50)
        {
            if(batteryHi_List.count == 0)
            {
                return getLiplisBody(emotion, point: point);
            }
            else
            {
                return selectBody(batteryHi_List);
            }
        }
            //中破
        else if(helth > 25)
        {
            if(batteryMid_List.count == 0)
            {
                return getLiplisBody(emotion, point: point);
            }
            else
            {
                return selectBody(batteryMid_List);
            }
        }
            //大破
        else
        {
            if(batteryLow_List.count == 0)
            {
                return getLiplisBody(emotion, point: point);
            }
            else
            {
                return selectBody(batteryLow_List);
            }
        }
    }
    func getLiplisBodyId(emotion: Int, point: Int ,eyeState: Int, mouthState: Int)->String
    {
        var body : ObjBody = getLiplisBody(emotion,point: point)
        return body.getLiplisBodyId(eyeState, mouthState: mouthState)
    }

    
    
    func getLiplisBodyByEmotionList(emotionList : Array<Int> , pointList : Array<Int> )->ObjBody
    {
        //インデックス
        var idx : Int = 0
        var max : Int = 0 //マックス値
        var maxIdx : Int = 0
        
        // 感情値
        var emotionArray : Array<Int> = [0,0,0,0,0,0,0,0,0,0,0]
        var pEmo : Int = 0
        
        
        //リストが空ならノーマルを返しておく
        if(!emotionList.isEmpty){return selectBody(normalList)}
        
        //エモーションリストを回して積算エモーション値を算出
        for emotion in emotionList
        {
            emotionArray[emotion] = emotionArray[emotion] + emotionList[idx];
            idx++
        }
        
        //積算エモーション値からマックス値を取得
        for (idx = 1; idx<emotionArray.count; idx++) {   //(2)
            pEmo = abs(emotionArray[idx])
            if(pEmo > 0)
            {
                if(pEmo >= max)
            {
            //マックス値更新
            max    = pEmo
            
            //マックスIDを取得しておく(同値でも後がち)
            maxIdx = idx
            }
        }
        
        }
        
        //マックスIDのエモーションを返す
        return getLiplisBody(maxIdx,point: 99)
    }
    
    /**
        ボディデータをリストからランダムで１個選択し、返す
    */
    func selectBody(bodyList : Array<ObjBody>)->ObjBody
    {
        if bodyList.count>0
        {
            var idx = LiplisUtil.getRandormNumber(Min: 0, Max: bodyList.count - 1)
            return bodyList[idx]
        }
        
        //リストが0の場合、ノーマルリストの頭を返しておく
        return normalList[0]
    }
    
    /**
        デフォルトのボディを返す
    */
    func getDefaultBody()->ObjBody
    {
        return normalList[0]
    }
    
}