//
//  ObjLiplisBody.swift
//  Liplis
//
//  立ち絵管理クラス
//  body.xmlのインスタンス
//
//  NSXMLParserDelegateを使うためには、NSObjectも継承する
//
//
//アップデート履歴
//   2015/04/12 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0 swift1.2対応
//
//  Created by sachin on 2015/04/12.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit
import Foundation

class ObjLiplisBody : NSObject, NSXMLParserDelegate {
    //=================================
    //プロパティ
    internal var bodyPath : String! = ""
    internal var height : CGFloat!
    internal var width : CGFloat!
    internal var heightReal : CGFloat!
    internal var widthReal : CGFloat!
    internal var locationX : Int!
    internal var locationY : Int!
    
    //=================================
    //立ち絵リスト
    internal var normalList : Array<ObjBody> = []
    internal var joy_p_List : Array<ObjBody> = []
    internal var joy_m_List : Array<ObjBody> = []
    internal var admiration_p_List : Array<ObjBody> = []
    internal var admiration_m_List : Array<ObjBody> = []
    internal var peace_p_List : Array<ObjBody> = []
    internal var peace_m_List : Array<ObjBody> = []
    internal var ecstasy_p_List : Array<ObjBody> = []
    internal var ecstasy_m_List : Array<ObjBody> = []
    internal var amazement_p_List : Array<ObjBody> = []
    internal var amazement_m_List : Array<ObjBody> = []
    internal var rage_p_List : Array<ObjBody> = []
    internal var rage_m_List : Array<ObjBody> = []
    internal var interest_p_List : Array<ObjBody> = []
    internal var interest_m_List : Array<ObjBody> = []
    internal var respect_p_List : Array<ObjBody> = []
    internal var respect_m_List : Array<ObjBody> = []
    internal var calmly_p_List : Array<ObjBody> = []
    internal var calmly_m_List : Array<ObjBody> = []
    internal var proud_p_List : Array<ObjBody> = []
    internal var proud_m_List : Array<ObjBody> = []
    
    internal var batteryHi_List : Array<ObjBody> = []
    internal var batteryMid_List : Array<ObjBody> = []
    internal var batteryLow_List : Array<ObjBody> = []
    internal var sleep : UIImage!
    
    //=================================
    //XML操作一時変数
    internal var _ParseKey: String! = ""
    internal var _body : ObjBody!

    //=================================
    //スリープファイル名
    internal let SLEEP_FILE_NAME : String = "sleep"
    
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
    internal init(url : NSURL, bodyPath : String)
    {
        //スーパークラスのイニット
        super.init()
        
        //ボディパスの取得
        self.bodyPath = bodyPath
        
        //リストの初期化
        self.initList()
        
        //スリープ画像の初期化
        self.initSleep()
        
        //プロパティの初期化
        self.initProperty()
        
        //ロードXML
        self.loadXml(url)
        
        //アスペクト比算出
        self.culcAspectRatio()
    }
    
    /**
        リストの初期化
    */
    internal func initList()
    {
        self.normalList = Array<ObjBody>()
        self.joy_p_List = Array<ObjBody>()
        self.joy_m_List = Array<ObjBody>()
        self.admiration_p_List = Array<ObjBody>()
        self.admiration_m_List = Array<ObjBody>()
        self.peace_p_List = Array<ObjBody>()
        self.peace_m_List = Array<ObjBody>()
        self.ecstasy_p_List = Array<ObjBody>()
        self.ecstasy_m_List = Array<ObjBody>()
        self.amazement_p_List = Array<ObjBody>()
        self.amazement_m_List = Array<ObjBody>()
        self.rage_p_List = Array<ObjBody>()
        self.rage_m_List = Array<ObjBody>()
        self.interest_p_List = Array<ObjBody>()
        self.interest_m_List = Array<ObjBody>()
        self.respect_p_List = Array<ObjBody>()
        self.respect_m_List = Array<ObjBody>()
        self.calmly_p_List = Array<ObjBody>()
        self.calmly_m_List = Array<ObjBody>()
        self.proud_p_List = Array<ObjBody>()
        self.proud_m_List = Array<ObjBody>()
        
        self.batteryHi_List = Array<ObjBody>()
        self.batteryMid_List = Array<ObjBody>()
        self.batteryLow_List = Array<ObjBody>()
    }
    
    
    /**
    スリープ画像の初期化
    */
    internal func initSleep()
    {
        self.sleep = UIImage(contentsOfFile: self.bodyPath + "/sleep.png")
    }
    
    /**
    プロパティの初期化
    */
    internal func initProperty()
    {
        self.height = 0
        self.width = 0
        self.locationX = 0
        self.locationY = 0
    }
    
    /**
    アスペクト比の計算
    */
    internal func culcAspectRatio()
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
    
    /**
    ノーマルグラフィックを取得する
    */
    internal func getNormalGraphic()->UIImage
    {
        return self.normalList[0].getLiplisBodyImgIdIns(0,mouthState: 0)
    }
    
    //============================================================
    //
    //XMLロード
    //
    //============================================================

    /**
        XMLのロード
    */
    internal func loadXml(url : NSURL)
    {
        let parser : NSXMLParser? = NSXMLParser(contentsOfURL: url)
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
    internal func parserDidStartDocument(parser: NSXMLParser)
    {
        //結果格納リストの初期化(イニシャラいざで初期化しているので省略)
    }
    
    /**
        更新処理
    */
    internal func parserDidEndDocument(parser: NSXMLParser)
    {
        // 画面など、他オブジェクトを更新する必要がある場合はここに記述する(必要ないので省略)
    }
    
    /**
        タグの読み始めに呼ばれる
    */
    //func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!)
    
    internal func parser(parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI : String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String])
    {
        self._ParseKey = elementName
        
        if elementName == "normal"              {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "joy_p"          {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "joy_m"          {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "admiration_p"   {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "admiration_m"   {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "peace_p"        {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "peace_m"        {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "ecstasy_p"      {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "ecstasy_m"      {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "amazement_p"    {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "amazement_m"    {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "rage_p"         {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "rage_m"         {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "interest_p"     {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "interest_m"     {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "respect_p"      {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "respect_m"      {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "calmly_p"       {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "calmly_m"       {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "proud_p"        {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "proud_m"        {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "batteryHi"      {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "batteryMid"     {self._body = ObjBody(bodyPath: self.bodyPath)}
        else if elementName == "batteryLow"     {self._body = ObjBody(bodyPath: self.bodyPath)}
    }
    
    /**
        タグの最後で呼ばれる
    */
    internal func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "normal"              {self.normalList.append(self._body)}
        else if elementName == "joy_p"          {self.joy_p_List.append(self._body)}
        else if elementName == "joy_m"          {self.joy_m_List.append(self._body)}
        else if elementName == "admiration_p"   {self.admiration_p_List.append(self.self._body)}
        else if elementName == "admiration_m"   {self.admiration_m_List.append(_body)}
        else if elementName == "peace_p"        {self.peace_p_List.append(self._body)}
        else if elementName == "peace_m"        {self.peace_m_List.append(self._body)}
        else if elementName == "ecstasy_p"      {self.ecstasy_p_List.append(self._body)}
        else if elementName == "ecstasy_m"      {self.ecstasy_m_List.append(self._body)}
        else if elementName == "amazement_p"    {self.amazement_p_List.append(self._body)}
        else if elementName == "amazement_m"    {self.amazement_m_List.append(self._body)}
        else if elementName == "rage_p"         {self.rage_p_List.append(self._body)}
        else if elementName == "rage_m"         {self.rage_m_List.append(self._body)}
        else if elementName == "interest_p"     {self.interest_p_List.append(self._body)}
        else if elementName == "interest_m"     {self.interest_m_List.append(self._body)}
        else if elementName == "respect_p"      {self.respect_p_List.append(self._body)}
        else if elementName == "respect_m"      {self.respect_m_List.append(self._body)}
        else if elementName == "calmly_p"       {self.calmly_p_List.append(self._body)}
        else if elementName == "calmly_m"       {self.calmly_m_List.append(self._body)}
        else if elementName == "proud_p"        {self.proud_p_List.append(self._body)}
        else if elementName == "proud_m"        {self.proud_m_List.append(self._body)}
        else if elementName == "batteryHi"      {self.batteryHi_List.append(self._body)}
        else if elementName == "batteryMid"     {self.batteryMid_List.append(self._body)}
        else if elementName == "batteryLow"     {self.batteryLow_List.append(self._body)}
        
        self._ParseKey = ""
    }
    
    /**
        パースする。
    */
    internal func parser(parser: NSXMLParser, foundCharacters value: String)
    {
        if (self._ParseKey == "emotion") {
            self._body!.emotion = value
        } else if (self._ParseKey.hasSuffix("11")) {
            self._body!.eye_1_c = value
        } else if (self._ParseKey.hasSuffix("12")) {
            self._body!.eye_1_o = value
        } else if (self._ParseKey.hasSuffix("21")) {
            self._body!.eye_2_c = value
        } else if (self._ParseKey.hasSuffix("22")) {
            self._body!.eye_2_o = value
        } else if (self._ParseKey.hasSuffix("31")) {
            self._body!.eye_3_c = value
        } else if (self._ParseKey.hasSuffix("32")) {
            self._body!.eye_3_o = value
        } else if (self._ParseKey.hasSuffix("height")) {
            self.height = CGFloat(Int(value)!)
        } else if (self._ParseKey.hasSuffix("width")) {
            self.width = CGFloat(Int(value)!)
        } else if (self._ParseKey.hasSuffix("locationX")) {
            self.locationX = Int(value)
        } else if (self._ParseKey.hasSuffix("locationY")) {
            self.locationY = Int(value)
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
    internal func getLiplisBody(emotion : Int, point : Int)->ObjBody
    {
        var body : ObjBody = ObjBody()
        
        if(point > 0)
        {
            switch(emotion)
            {
                case 0:body = self.selectBody(self.normalList)
                    break
                case 1:body = self.selectBody(self.joy_p_List)
                    break
                case 2:body = self.selectBody(self.admiration_p_List)
                    break
                case 3:body = self.selectBody(self.peace_p_List)
                    break
                case 4:body = self.selectBody(self.ecstasy_p_List)
                    break
                case 5:body = self.selectBody(self.amazement_p_List)
                    break
                case 6:body = self.selectBody(self.rage_p_List)
                    break
                case 7:body = self.selectBody(self.interest_p_List)
                    break
                case 8:body = self.selectBody(self.respect_p_List)
                    break
                case 9:body = self.selectBody(self.calmly_p_List)
                    break
                case 10:body = self.selectBody(self.proud_p_List)
                    break
                default:body = self.selectBody(self.normalList)
                    break
            }
        }
        else
        {
            switch(emotion)
            {
                case 0:body = self.selectBody(self.normalList)
                    break
                case 1:body = self.selectBody(self.joy_m_List)
                    break
                case 2:body = self.selectBody(self.admiration_m_List)
                    break
                case 3:body = self.selectBody(self.peace_m_List)
                    break
                case 4:body = self.selectBody(self.ecstasy_m_List)
                    break
                case 5:body = self.selectBody(self.amazement_m_List)
                    break
                case 6:body = self.selectBody(self.rage_m_List)
                    break
                case 7:body = self.selectBody(self.interest_m_List)
                    break
                case 8:body = self.selectBody(self.respect_m_List)
                    break
                case 9:body = self.selectBody(self.calmly_m_List)
                    break
                case 10:body = self.selectBody(self.proud_m_List)
                    break
                default:body = self.selectBody(self.normalList)
                    break
            }
        }
        
        return body
    }
    
    
    internal func getLiplisBodyHelth(helth : Int,emotion : Int, point : Int)->ObjBody
    {
        //小破以上
        if(helth > 50)
        {
            if(self.batteryHi_List.count == 0)
            {
                return self.getLiplisBody(emotion, point: point);
            }
            else
            {
                return self.selectBody(self.batteryHi_List);
            }
        }
            //中破
        else if(helth > 25)
        {
            if(self.batteryMid_List.count == 0)
            {
                return self.getLiplisBody(emotion, point: point);
            }
            else
            {
                return self.selectBody(self.batteryMid_List);
            }
        }
            //大破
        else
        {
            if(self.batteryLow_List.count == 0)
            {
                return self.getLiplisBody(emotion, point: point);
            }
            else
            {
                return self.selectBody(self.batteryLow_List);
            }
        }
    }
    internal func getLiplisBodyId(emotion: Int, point: Int ,eyeState: Int, mouthState: Int)->String
    {
        let body : ObjBody = getLiplisBody(emotion,point: point)
        return body.getLiplisBodyId(eyeState, mouthState: mouthState)
    }

    
    
    internal func getLiplisBodyByEmotionList(emotionList : Array<Int> , pointList : Array<Int> )->ObjBody
    {
        //インデックス
        var idx : Int = 0
        var max : Int = 0 //マックス値
        var maxIdx : Int = 0
        
        // 感情値
        var emotionArray : Array<Int> = [0,0,0,0,0,0,0,0,0,0,0]
        var pEmo : Int = 0
        
        
        //リストが空ならノーマルを返しておく
        if(!emotionList.isEmpty){return self.selectBody(self.normalList)}
        
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
        return self.getLiplisBody(maxIdx,point: 99)
    }
    
    /**
        ボディデータをリストからランダムで１個選択し、返す
        ver1.1.0 リストの一番最後のポーズが選択されないようになっていたバグ修正
    */
    internal func selectBody(bodyList : Array<ObjBody>)->ObjBody
    {
        if bodyList.count>0
        {
            let idx = LiplisUtil.getRandormNumber(Min: 0, Max: bodyList.count)
            return bodyList[idx]
        }
        
        //リストが0の場合、ノーマルリストの頭を返しておく
        return self.normalList[0]
    }
    
    /**
        デフォルトのボディを返す
    */
    internal func getDefaultBody()->ObjBody
    {
        return self.normalList[0]
    }
    
}