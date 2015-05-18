//
//  CtvCellMenuHelpSite.swift
//  Liplis
//
//設定メニュー画面 要素 ヘルプ
//
//アップデート履歴
//   2015/05/04 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　リファクタリング
//
//  Created by sachin on 2015/05/04.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellMenuHelpSite : UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    internal var parView : ViewSettingMenu!
    
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
        self.lblTitle.text = "Liplisのヘルプを内部ブラウザで開きます。";
        self.lblTitle.numberOfLines = 2
        self.lblTitle.font = UIFont.systemFontOfSize(15)
        self.addSubview(self.lblTitle);

        //ボタン
        self.btnHelp = UIButton()
        self.btnHelp.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.btnHelp.frame = CGRectMake(0,5,40,48)
        self.btnHelp.layer.masksToBounds = true
        self.btnHelp.setTitle("Liplis ヘルプ", forState: UIControlState.Normal)
        self.btnHelp.addTarget(self, action: "onClick:", forControlEvents: .TouchDown)
        self.btnHelp.layer.cornerRadius = 3.0
        self.btnHelp.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        
        self.addSubview(self.btnHelp)
    }
    
    /*
    ビューを設定する
    */
    internal func setView(parView : ViewSettingMenu)
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
        self.parView.app.activityWeb.url = NSURL(string: LiplisDefine.SITE_LIPLIS_HELP)!
        self.parView.tabBarController?.selectedIndex=4
    }
}