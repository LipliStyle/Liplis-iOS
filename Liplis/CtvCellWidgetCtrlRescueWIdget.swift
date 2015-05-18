//
//  CtvCellWidgetCtrlRescueWIdget.swift
//  Liplis
//
//ウィジェット操作 要素 ウィジェット全復帰
//
//アップデート履歴
//   2015/05/07 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　リファクタリング
//
//  Created by sachin on 2015/05/07.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellWidgetCtrlRescueWIdget : UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    internal var parView : ViewWidgetCtrl!
    
    ///=============================
    ///カスタムセル要素
    internal var lblTitle = UILabel();
    internal var btnHelp = UIButton();
    
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
        
        self.lblTitle = UILabel(frame: CGRectMake(10, 23, 300, 15));
        self.lblTitle.text = "全てのウィジェットを画面内に呼び戻します。";
        self.lblTitle.font = UIFont.systemFontOfSize(15)
        self.lblTitle.numberOfLines = 2
        self.addSubview(self.lblTitle);
        
        //ボタン
        self.btnHelp = UIButton()
        self.btnHelp.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.btnHelp.frame = CGRectMake(0,5,40,48)
        self.btnHelp.layer.masksToBounds = true
        self.btnHelp.setTitle("実行", forState: UIControlState.Normal)
        self.btnHelp.addTarget(self, action: "onClick:", forControlEvents: .TouchDown)
        self.btnHelp.layer.cornerRadius = 3.0
        self.btnHelp.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        self.addSubview(self.btnHelp)
    }
    
    /*
    ビューを設定する
    */
    internal func setView(parView : ViewWidgetCtrl)
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
        var locationX : CGFloat = CGFloat(viewWidth - viewWidth/4 - 5)
        self.btnHelp.frame = CGRectMake(locationX, 5,viewWidth/4,60)
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
        let myAlert: UIAlertController = UIAlertController(title: "ウィジェット復帰", message: "全てのウィジェットを画面上に復帰させますか？", preferredStyle: .Alert)
        let myOkAction = UIAlertAction(title: "実行", style: .Default) { action in
            self.parView.app.activityDeskTop.rescueWidgetAll()
            println("実行しました。")
        }
        let myCancelAction = UIAlertAction(title: "キャンセル", style: .Default) { action in
            println("中止しました。")
        }
        
        myAlert.addAction(myOkAction)
        myAlert.addAction(myCancelAction)
        self.parView.presentViewController(myAlert, animated: true, completion: nil)
    }
}