//
//  CtvCellWidgetController.swift
//  Liplis
//
//ウィジェットメニュー画面 要素 ウィジェット操作
//
//アップデート履歴
//   2015/05/05 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　リファクタリング
//
//  Created by sachin on 2015/05/05.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellWidgetController : UITableViewCell
{
    ///=============================
    ///親画面インスタンス
    internal var parView : ViewWidgetMenu!
    
    ///=============================
    ///カスタムセル要素
    internal var btnNext : UIButton!
    internal var btnSleep : UIButton!
    internal var btnBattery : UIButton!
    internal var btnClock : UIButton!
    
    ///=============================
    ///レイアウト情報
    internal var viewWidth : CGFloat! = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    internal override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //ボタン
        self.btnNext = UIButton()
        self.btnNext.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.btnNext.frame = CGRectMake(0,5,70,50)
        self.btnNext.layer.masksToBounds = true
        self.btnNext.setTitle("次の話題", forState: UIControlState.Normal)
        self.btnNext.addTarget(self, action: "onClickNext:", forControlEvents: .TouchDown)
        self.btnNext.layer.cornerRadius = 3.0
        self.btnNext.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        self.btnSleep = UIButton()
        self.btnSleep.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.btnSleep.frame = CGRectMake(0,5,70,50)
        self.btnSleep.layer.masksToBounds = true
        self.btnSleep.setTitle("おやすみ", forState: UIControlState.Normal)
        self.btnSleep.addTarget(self, action: "onClickSleep:", forControlEvents: .TouchDown)
        self.btnSleep.layer.cornerRadius = 3.0
        self.btnSleep.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        self.btnBattery = UIButton()
        self.btnBattery.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.btnBattery.frame = CGRectMake(0,5,70,50)
        self.btnBattery.layer.masksToBounds = true
        self.btnBattery.setTitle("電池", forState: UIControlState.Normal)
        self.btnBattery.addTarget(self, action: "onClickBattery:", forControlEvents: .TouchDown)
        self.btnBattery.layer.cornerRadius = 3.0
        self.btnBattery.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        self.btnClock = UIButton()
        self.btnClock.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.btnClock.frame = CGRectMake(0,5,70,50)
        self.btnClock.layer.masksToBounds = true
        self.btnClock.setTitle("時計", forState: UIControlState.Normal)
        self.btnClock.addTarget(self, action: "onClickClock:", forControlEvents: .TouchDown)
        self.btnClock.layer.cornerRadius = 3.0
        self.btnClock.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        
        
        self.addSubview(btnNext)
        self.addSubview(btnSleep)
        self.addSubview(btnBattery)
        self.addSubview(btnClock)
    }
    
    /*
    ビューを設定する
    */
    internal func setView(parView : ViewWidgetMenu)
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
    internal func setSize(viewWidth : CGFloat)
    {
        self.viewWidth = viewWidth
        self.btnNext.frame = CGRectMake(viewWidth/128, 5,viewWidth/4 - viewWidth/64 ,50)
        self.btnSleep.frame = CGRectMake(self.btnNext.frame.origin.x + self.btnNext.frame.width + viewWidth/64, 5,viewWidth/4 - viewWidth/64,50)
        self.btnBattery.frame = CGRectMake(self.btnSleep.frame.origin.x + self.btnSleep.frame.width + viewWidth/64, 5,viewWidth/4 - viewWidth/64,50)
        self.btnClock.frame = CGRectMake(self.btnBattery.frame.origin.x + self.btnBattery.frame.width + viewWidth/64, 5,viewWidth/4 - viewWidth/64,50)
    }
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    /*
    次の話題
    */
    internal func onClickNext(sender: UIButton) {
        self.parView.widgetNext()
    }
    
    /*
    おやすみ
    */
    internal func onClickSleep(sender: UIButton) {
        self.parView.widgetSleep()
    }
    
    /*
    バッテリー
    */
    internal func onClickBattery(sender: UIButton) {
        self.parView.widgetBattery()
    }
    
    /*
    時刻
    */
    internal func onClickClock(sender: UIButton) {
        self.parView.widgetClock()
    }
}