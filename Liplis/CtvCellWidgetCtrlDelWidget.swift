//
//  CtvCellWidgetCtrl.swift
//  Liplis
//
//  Created by kosuke on 2015/05/07.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellWidgetCtrlDelWidget : UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    var parView : ViewWidgetCtrl!
    
    ///=============================
    ///カスタムセル要素
    var lblTitle = UILabel();
    var btnHelp = UIButton();
    
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
        
        lblTitle = UILabel(frame: CGRectMake(10, 23, 300, 15));
        lblTitle.text = "デスクトップに配置されているウィジェットを全て削除します。";
        lblTitle.font = UIFont.systemFontOfSize(15)
        lblTitle.numberOfLines = 2
        self.addSubview(lblTitle);
        
        //ボタン
        btnHelp = UIButton()
        btnHelp.titleLabel?.font = UIFont.systemFontOfSize(16)
        btnHelp.frame = CGRectMake(0,5,40,48)
        btnHelp.layer.masksToBounds = true
        btnHelp.setTitle("実行", forState: UIControlState.Normal)
        btnHelp.addTarget(self, action: "onClick:", forControlEvents: .TouchDown)
        btnHelp.layer.cornerRadius = 3.0
        btnHelp.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        self.addSubview(btnHelp)
    }
    
    /*
    ビューを設定する
    */
    func setView(parView : ViewWidgetCtrl)
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
        var locationX : CGFloat = CGFloat(viewWidth - viewWidth/4 - 5)
        btnHelp.frame = CGRectMake(locationX, 5,viewWidth/4,60)
        lblTitle.frame = CGRectMake(10, 5,viewWidth * 3/4 - 20,50)
    }
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    /*
    スイッチ選択
    */
    func onClick(sender: UIButton) {
        let myAlert: UIAlertController = UIAlertController(title: "ウィジェット削除", message: "全てのウィジェットを削除しますか？", preferredStyle: .Alert)
        let myOkAction = UIAlertAction(title: "実行", style: .Default) { action in
            self.parView.app.activityDeskTop.delWidgetAll()
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