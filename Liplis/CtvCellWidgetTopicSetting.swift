//
//  CtvCellWidgetTopicSetting.swift
//  Liplis
//
//ウィジェットメニュー画面 要素 ウィジェット話題設定
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
class CtvCellWidgetTopicSetting : UITableViewCell
{
    ///=============================
    ///親画面インスタンス
    internal var parView : ViewWidgetMenu!
    
    ///=============================
    ///カスタムセル要素
    internal var lblTitle = UILabel();
    internal var btnRun = UIButton();
    
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
        
        self.lblTitle = UILabel(frame: CGRectMake(10, 23, 300, 30));
        self.lblTitle.text = "おしゃべりの話題を設定します。";
        self.lblTitle.font = UIFont.systemFontOfSize(15)
        self.lblTitle.numberOfLines = 2
        self.addSubview(self.lblTitle);
        
        //ボタン
        self.btnRun = UIButton()
        self.btnRun.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.btnRun.frame = CGRectMake(0,5,40,48)
        self.btnRun.layer.masksToBounds = true
        self.btnRun.setTitle("話題設定", forState: UIControlState.Normal)
        self.btnRun.addTarget(self, action: "onClick:", forControlEvents: .TouchDown)
        self.btnRun.layer.cornerRadius = 3.0
        self.btnRun.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        self.addSubview(self.btnRun)
    }
    
    /*
    ビューを設定する
    */
    internal func setView(parView : ViewWidgetMenu)
    {
        self.parView = parView
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    /*
    要素の位置を調整する
    */
    internal func setSize(viewWidth : CGFloat)
    {
        self.viewWidth = viewWidth
        let locationX : CGFloat = CGFloat(viewWidth - viewWidth/4 - 5)
        self.btnRun.frame = CGRectMake(locationX, 5,viewWidth/4,50)
        self.lblTitle.frame = CGRectMake(10, 5,viewWidth * 3/4 - 20,50)
    }
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    /*
    スイッチ選択
    */
    internal func onClick(sender: UIButton) {
        let modalView : ViewWidgetTopicSetting = ViewWidgetTopicSetting(widget: parView.widget)
        modalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.parView.presentViewController(modalView, animated: true, completion: nil)
    }
}