//
//  CtvCellMenuIntoroduction.swift
//  Liplis
//
//  Created by sachin on 2015/05/04.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellMenuIntoroduction: UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    var lblIntoroduction : UILabel!
    var imgChar: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //キャラクターイメージ設定
        imgChar = UIImageView(frame: CGRectMake(4,5,96,96))
        imgChar.image = UIImage(named: "liliIcon.png")
        self.addSubview(imgChar);
        
        //ラベル設定
        lblIntoroduction = UILabel(frame: CGRectMake(imgChar.frame.origin.x + imgChar.frame.width + 5, 5, 300, 96));
        lblIntoroduction.numberOfLines = 4
        lblIntoroduction.text = "リプリスの設定メニューです。\nLiplisの基本設定を行うことができます。\nご不明点につきましてはヘルプ、\nLipliStyleのサイトをご確認下さい。";
        lblIntoroduction.font = UIFont.systemFontOfSize(12)
        
        self.addSubview(lblIntoroduction);
        

    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
