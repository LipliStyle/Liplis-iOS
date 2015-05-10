	//
//  ObjLiplisChat.swift
//  Liplis
//
//  Created by kosuke on 2015/04/16.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import Foundation
class ObjLiplisChat : NSObject, NSXMLParserDelegate {
    ///=============================
    /// バージョン 追加
    var version : String! = "1.0"
    
    ///=============================
    /// ボディ
    var nameList : Array<String> = []			//メッセージ名
    var typeList : Array<String> = []			//タイプ
    var discriptionList : Array<String> = []	//内容
    var emotionList : Array<Int> = []			//エモーション
    var prerequisiteList : Array<String> = []	//発言条件
    
    //=================================
    //XML操作一時変数
    var _ParseKey: String! = ""
    var _Value: String! = ""
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
        デフォルトイニシャライザ
    */
    init(url : NSURL)
    {
        //スーパークラスのイニット
        super.init()
        
        //リストの初期化
        initList()
        
        //ロードXML
        loadXml(url)
    }
    
    /**
        リストの初期化
    */
    func initList()
    {
        nameList = Array<String>()
        typeList = Array<String>()
        discriptionList = Array<String>()
        emotionList = Array<Int>()
        prerequisiteList = Array<String>()
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
        //エレメント取得
        _ParseKey = elementName
    }
    
    /**
        タグの最後で呼ばれる
    */
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (_ParseKey == "name") {
            nameList.append(_Value!)
        } else if (_ParseKey == "type") {
            typeList.append(_Value!)
        } else if (_ParseKey == "discription") {
            discriptionList.append(_Value!)
        } else if (_ParseKey == "emotion") {
            emotionList.append(_Value.toInt()!)
        } else if (_ParseKey == "prerequisite") {
            prerequisiteList.append(_Value!)
        } else {
            // nop
        }
        
        //エレメント初期化
        _ParseKey = ""
        _Value = ""
    }
    
    /**
        パースする。
    */
    func parser(parser: NSXMLParser!, foundCharacters value: String!)
    {
        if (_ParseKey == "name") {
            _Value = _Value + value!
        } else if (_ParseKey == "type") {
            _Value = _Value + value!
        } else if (_ParseKey == "discription") {
            _Value = _Value + value!
        } else if (_ParseKey == "emotion") {
            _Value = _Value + value!
        } else if (_ParseKey == "prerequisite") {
            _Value = _Value + value!
        } else {
            // nop
        }
    }
    
    //============================================================
    //
    //おしゃべりストリング取得処理
    //
    //============================================================
   
    /**
    あいさつ
    */
    func getGreet()->MsgShortNews
    {
        var result : MsgShortNews = MsgShortNews()
        var prerequinste : String = ""
        var timeList : Array<String>
        var startList : Array<String>
        var endList : Array<String>
        var idx = 0
        var nowHour : Int = 0
        var nowMin : Int = 0
        var startHour : Int = 0
        var startMin : Int = 0
        var endHour : Int = 0
        var endMin : Int = 0
        
        //対象インデックスリスト
        var resList : Array<Int> = Array<Int>()
        
        //時間に合致する挨拶を検索
        for type in typeList {
            //挨拶なら対象
            if(type == "greet"){
                
                prerequinste = prerequisiteList[idx]
                timeList = split(prerequinste,{$0 == ","})
                
                if(timeList.count == 2)
                {
                    startList = split(timeList[0],{$0 == ":"});
                    endList = split(timeList[1],{$0 == ":"});
                    
                    if(startList.count == 2 && endList.count == 2)
                    {
                        let date = NSDate()
                        let calendar = NSCalendar.currentCalendar()
                        var comps:NSDateComponents = calendar.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit|NSCalendarUnit.DayCalendarUnit|NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit|NSCalendarUnit.SecondCalendarUnit,fromDate: date)
                        
                        nowHour = comps.hour
                        nowMin = comps.minute
                        
                        startHour = startList[0].toInt()!
                        startMin = startList[1].toInt()!
                        
                        endHour = endList[0].toInt()!
                        endMin = endList[1].toInt()!
                        
                        //スタートアワーの場合、分を確認
                        if(nowHour == startHour && nowMin >= startMin)
                        {
                            if(nowHour == endHour && nowMin <= endMin)
                            {
                                resList.append(idx);
                            }
                            else if(nowHour < endHour)
                            {
                                resList.append(idx);
                            }
                        }
                        else if(nowHour >= startHour)
                        {
                            if(nowHour == endHour && nowMin <= endMin)
                            {
                                resList.append(idx);
                            }
                            else if(nowHour < endHour)
                            {
                                resList.append(idx);
                            }
                        }
                    }
                }
            }
            idx++
        }
        
        //候補が置ければ1個目を取得
        if(resList.count > 0)
        {
            if(nameList.count > 0)
            {
                var ran : Int = LiplisUtil.getRandormNumber(Min: 0,Max: resList.count - 1)
                var tarIdx : Int = resList[ran]
                
                result = MsgShortNews(name: discriptionList[tarIdx], emotion: emotionList[tarIdx], point: 99)
            }
            else
            {
                result = MsgShortNews(name: "", emotion: 0, point: 0)
            }
        }
        return result
    }
    
    /**
    対象のタイプのセリフを1つランダムに返す
    */
    func getChatWord(pType : String)->MsgShortNews
    {
        var result : MsgShortNews  = MsgShortNews()
        var idx : Int = 0
        
        //対象インデックスリスト
        var resList : Array<Int> = Array<Int>();
        
        //時間に合致する挨拶を検索
        for type in typeList {
            //挨拶なら対象
            if(type == pType){
                resList.append(idx)
            }
            idx++
        }
        
        //候補が置ければ1個目を取得
        if(resList.count > 0)
        {
            if(nameList.count > 0)
            {
                var ran : Int = LiplisUtil.getRandormNumber(Min: 0,Max: resList.count - 1)
                var tarIdx : Int = resList[ran]
                
                result = MsgShortNews(name: discriptionList[tarIdx], emotion: emotionList[tarIdx], point: 99)
            }
            else
            {
                result = MsgShortNews(name: "", emotion: 0, point: 0)
            }
        }
        
        return result;
    }
    
    /**
    対象のタイプのセリフを1つランダムに返す
    */
    func getChatWordStr(pType : String)->String
    {
        var result : String = ""
        var idx : Int = 0
        
        //対象インデックスリスト
        var resList : Array<Int> = Array<Int>();
        
        //時間に合致する挨拶を検索
        for type in typeList {
            //挨拶なら対象
            if(type == pType){
                resList.append(idx)
            }
            idx++
        }
        
        //候補が置ければ1個目を取得
        if(resList.count > 0)
        {
            if(nameList.count > 0)
            {
                var ran : Int = LiplisUtil.getRandormNumber(Min: 0,Max: resList.count - 1)
                var tarIdx : Int = resList[ran]
                
                result = discriptionList[tarIdx]
            }
            else
            {
                result = ""
            }
        }
        else
        {
            result = ""
        }
        
        return result
    }
    
    /**
    バッテリー情報を取得する
    */
    func getBatteryInfo(batteryLevel : Int)->MsgShortNews
    {
        
        var result : MsgShortNews
        var batteryWord : MsgShortNews
        var resStr : String = ""
        
        //電池容量のセリフを取得
        result = getChatWord("batteryInfo")
        
        //空だったら、電池格納用ワードを入れておく
        if(result.nameList.count == 0)
        {
            result.nameList.append("[?]%")
            result.emotionList.append(0)
            result.pointList.append(0)
            return result
        }
        
        //バッテリーレベルによってセリフを変える
        if(batteryLevel > 70)
        {
            batteryWord = getChatWord("batteryHi")
        }
        else if(batteryLevel > 30)
        {
            batteryWord = getChatWord("batteryMid")
        }
        else if(batteryLevel > 0)
        {
            batteryWord = getChatWord("batteryLow")
        }
        else
        {
            batteryWord = MsgShortNews()
        }
        
        //メッセージ作成
        resStr = result.nameList[0]
        resStr = resStr.stringByReplacingOccurrencesOfString("[?]", withString: String(batteryLevel), options: nil, range: nil)
        result = MsgShortNews(name: resStr, emotion: result.emotionList[0], point: result.pointList[0])
        
        return result;
    }
    
    /**
    時刻情報を取得する
    */
    func getClockInfo()->MsgShortNews
    {
        var resStr : String = "";
        var nowTime : LiplisDate = LiplisDate()
        
        //時刻情報のセリフを取得
        resStr = getChatWordStr("clockInfo")
        
        //空だったら、電池格納用ワードを入れておく
        if(resStr == "")
        {
            resStr = nowTime.getNormalFormatDate();
        }
        else
        {
            resStr = resStr.stringByReplacingOccurrencesOfString("[?]", withString: nowTime.getNormalFormatDate())
        }
        
        return MsgShortNews(name: resStr, emotion: 1, point: 1)
    }
    
    /**
    時報を取得する
    */
    func getTimeSignal(hour : Int)->MsgShortNews!
    {
        var result : MsgShortNews = MsgShortNews();
        var buf : MsgShortNews;
        
        switch hour
        {
        case 1: 
            buf = getChatWord("1Oclock")
        case 2: 
            buf = getChatWord("2Oclock")
        case 3: 
            buf = getChatWord("3Oclock")
        case 4: 
            buf = getChatWord("4Oclock")
        case 5: 
            buf = getChatWord("5Oclock")
        case 6: 
            buf = getChatWord("6Oclock")
        case 7: 
            buf = getChatWord("7Oclock")
        case 8: 
            buf = getChatWord("8Oclock")
        case 9: 
            buf = getChatWord("9Oclock")
        case 10: 
            buf = getChatWord("10Oclock")
        case 11: 
            buf = getChatWord("11Oclock")
        case 12:
            buf = getChatWord("12Oclock")
        case 13: 
            buf = getChatWord("13Oclock")
        case 14: 
            buf = getChatWord("14Oclock")
        case 15: 
            buf = getChatWord("15Oclock")
        case 16: 
            buf = getChatWord("16Oclock")
        case 17: 
            buf = getChatWord("17Oclock")
        case 18: 
            buf = getChatWord("18Oclock")
        case 19: 
            buf = getChatWord("19Oclock")
        case 20: 
            buf = getChatWord("20Oclock")
        case 21: 
            buf = getChatWord("21Oclock")
        case 22:
            buf = getChatWord("22Oclock")
        case 23: 
            buf = getChatWord("23Oclock")
        case 0: 
            buf = getChatWord("24Oclock")
        default:
            return result;
        }
        
        if buf.nameList.count != 0
        {
            return MsgShortNews(name: buf.nameList[0].stringByReplacingOccurrencesOfString("@", withString : ""), emotion: buf.emotionList[0], point: buf.pointList[0])
        }
        else
        {
            return nil
        }
        
        
    }
}