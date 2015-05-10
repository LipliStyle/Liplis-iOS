//
//  CtvCellWidgetController.swift
//  Liplis
//
//  Created by kosuke on 2015/05/05.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellWidgetController : UITableViewCell
{
    ///=============================
    ///親画面インスタンス
    var parView : ViewWidgetMenu!
    
    ///=============================
    ///カスタムセル要素
    var btnNext : UIButton!
    var btnSleep : UIButton!
    var btnBattery : UIButton!
    var btnClock : UIButton!
    
    ///=============================
    ///レイアウト情報
    var viewWidth : CGFloat! = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //ボタン
        btnNext = UIButton()
        btnNext.titleLabel?.font = UIFont.systemFontOfSize(16)
        btnNext.frame = CGRectMake(0,5,70,50)
        btnNext.layer.masksToBounds = true
        btnNext.setTitle("次の話題", forState: UIControlState.Normal)
        btnNext.addTarget(self, action: "onClickNext:", forControlEvents: .TouchDown)
        btnNext.layer.cornerRadius = 3.0
        btnNext.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        btnSleep = UIButton()
        btnSleep.titleLabel?.font = UIFont.systemFontOfSize(16)
        btnSleep.frame = CGRectMake(0,5,70,50)
        btnSleep.layer.masksToBounds = true
        btnSleep.setTitle("おやすみ", forState: UIControlState.Normal)
        btnSleep.addTarget(self, action: "onClickSleep:", forControlEvents: .TouchDown)
        btnSleep.layer.cornerRadius = 3.0
        btnSleep.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        btnBattery = UIButton()
        btnBattery.titleLabel?.font = UIFont.systemFontOfSize(16)
        btnBattery.frame = CGRectMake(0,5,70,50)
        btnBattery.layer.masksToBounds = true
        btnBattery.setTitle("電池", forState: UIControlState.Normal)
        btnBattery.addTarget(self, action: "onClickBattery:", forControlEvents: .TouchDown)
        btnBattery.layer.cornerRadius = 3.0
        btnBattery.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        btnClock = UIButton()
        btnClock.titleLabel?.font = UIFont.systemFontOfSize(16)
        btnClock.frame = CGRectMake(0,5,70,50)
        btnClock.layer.masksToBounds = true
        btnClock.setTitle("時計", forState: UIControlState.Normal)
        btnClock.addTarget(self, action: "onClickClock:", forControlEvents: .TouchDown)
        btnClock.layer.cornerRadius = 3.0
        btnClock.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        
        
        self.addSubview(btnNext)
        self.addSubview(btnSleep)
        self.addSubview(btnBattery)
        self.addSubview(btnClock)
    }
    
    /*
    ビューを設定する
    */
    func setView(parView : ViewWidgetMenu)
    {
        self.parView = parView
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    /*
    要素の位置を調整する
    */
    func setSize(viewWidth : CGFloat)
    {
        self.viewWidth = viewWidth
        btnNext.frame = CGRectMake(viewWidth/128, 5,viewWidth/4 - viewWidth/64 ,50)
        btnSleep.frame = CGRectMake(btnNext.frame.origin.x + btnNext.frame.width + viewWidth/64, 5,viewWidth/4 - viewWidth/64,50)
        btnBattery.frame = CGRectMake(btnSleep.frame.origin.x + btnSleep.frame.width + viewWidth/64, 5,viewWidth/4 - viewWidth/64,50)
        btnClock.frame = CGRectMake(btnBattery.frame.origin.x + btnBattery.frame.width + viewWidth/64, 5,viewWidth/4 - viewWidth/64,50)
    }
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    /*
    次の話題
    */
    func onClickNext(sender: UIButton) {
        parView.widgetNext()
    }
    
    /*
    おやすみ
    */
    func onClickSleep(sender: UIButton) {
        parView.widgetSleep()
    }
    
    /*
    バッテリー
    */
    func onClickBattery(sender: UIButton) {
        parView.widgetBattery()
    }
    
    /*
    時刻
    */
    func onClickClock(sender: UIButton) {
        parView.widgetClock()
    }
}