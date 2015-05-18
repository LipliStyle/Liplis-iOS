//
//  CtvCellMenuIntoroduction.swift
//  Liplis
//
//設定メニュー画面 要素 紹介
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
class CtvCellMenuIntoroduction: UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    internal var lblIntoroduction : UILabel!
    internal var imgChar: UIImageView!
    
    internal override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //キャラクターイメージ設定
        self.imgChar = UIImageView(frame: CGRectMake(4,5,96,96))
        self.imgChar.image = UIImage(named: "liliIcon.png")
        self.addSubview(self.imgChar);
        
        //ラベル設定
        self.lblIntoroduction = UILabel(frame: CGRectMake(imgChar.frame.origin.x + imgChar.frame.width + 5, 5, 300, 96));
        self.lblIntoroduction.numberOfLines = 4
        self.lblIntoroduction.text = "リプリスの設定メニューです。\nLiplisの基本設定を行うことができます。\nご不明点につきましてはヘルプ、\nLipliStyleのサイトをご確認下さい。";
        self.lblIntoroduction.font = UIFont.systemFontOfSize(12)
        
        self.addSubview(self.lblIntoroduction);
        

    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
