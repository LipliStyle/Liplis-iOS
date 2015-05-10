//
//  CtvCellMenuHelpSite.swift
//  Liplis
//
//  Created by kosuke on 2015/05/04.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellMenuHelpSite : UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    var parView : ViewSettingMenu!
    
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
        lblTitle.text = "Liplisのヘルプを内部ブラウザで開きます。";
        lblTitle.numberOfLines = 2
        lblTitle.font = UIFont.systemFontOfSize(15)
        self.addSubview(lblTitle);

        //ボタン
        btnHelp = UIButton()
        btnHelp.titleLabel?.font = UIFont.systemFontOfSize(16)
        btnHelp.frame = CGRectMake(0,5,40,48)
        btnHelp.layer.masksToBounds = true
        btnHelp.setTitle("Liplis ヘルプ", forState: UIControlState.Normal)
        btnHelp.addTarget(self, action: "onClick:", forControlEvents: .TouchDown)
        btnHelp.layer.cornerRadius = 3.0
        btnHelp.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        self.addSubview(btnHelp)
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
        parView.app.activityWeb.url = NSURL(string: LiplisDefine.SITE_LIPLIS_HELP)!
        parView.tabBarController?.selectedIndex=4
    }
}