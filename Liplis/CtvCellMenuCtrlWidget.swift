//
//  CtvCellMenuCtrlWidget.swift
//  Liplis
//
//  Created by sachin on 2015/05/07.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellMenuCtrlWidget : UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    var parView : ViewSettingMenu!
    
    ///=============================
    ///カスタムセル要素
    var lblTitle = UILabel();
    var btnRun = UIButton();
    
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
        
        lblTitle = UILabel(frame: CGRectMake(10, 23, 300, 30));
        lblTitle.text = "ウィジェットを操作します。";
        lblTitle.font = UIFont.systemFontOfSize(15)
        lblTitle.numberOfLines = 2
        self.addSubview(lblTitle);
        
        //ボタン
        btnRun = UIButton()
        btnRun.titleLabel?.font = UIFont.systemFontOfSize(16)
        btnRun.frame = CGRectMake(0,5,40,48)
        btnRun.layer.masksToBounds = true
        btnRun.setTitle("操作画面", forState: UIControlState.Normal)
        btnRun.addTarget(self, action: "onClick:", forControlEvents: .TouchDown)
        btnRun.layer.cornerRadius = 3.0
        btnRun.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        self.addSubview(btnRun)
    }
    
    /*
    ビューを設定する
    */
    func setView(parView : ViewSettingMenu)
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
        btnRun.frame = CGRectMake(locationX, 5,viewWidth/4,60)
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
        let modalView : ViewWidgetCtrl = ViewWidgetCtrl(app: self.parView.app)
        modalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        parView.presentViewController(modalView, animated: true, completion: nil)
    }
}