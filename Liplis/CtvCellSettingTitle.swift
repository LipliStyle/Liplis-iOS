//
//  CtvCellSettingTitle.swift
//  Liplis
//
//ウィジェット設定画面 要素 タイトル
//
//アップデート履歴
//   2015/05/01 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　リファクタリング
//
//  Created by sachin on 2015/05/01.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellSettingTitle: UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    internal var lblTitle = UILabel();
    
    internal override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //ラベル設定
        self.lblTitle = UILabel(frame: CGRectMake(10, 5, 300, 15));
        self.lblTitle.text = "";
        self.lblTitle.font = UIFont.systemFontOfSize(20)
        self.addSubview(self.lblTitle);
        
        //背景色設定
        self.backgroundColor = UIColor.hexStr("FEE360", alpha: 255)
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}