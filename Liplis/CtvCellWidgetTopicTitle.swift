//
//  CtvCellWidgetTopicTitle.swift
//  Liplis
//
//  Created by kosuke on 2015/05/05.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellWidgetTopicTitle: UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    var lblTitle = UILabel();
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //ラベル設定
        lblTitle = UILabel(frame: CGRectMake(10, 5, 300, 15));
        lblTitle.text = "";
        lblTitle.font = UIFont.systemFontOfSize(20)
        self.addSubview(lblTitle);
        
        //背景色設定
        self.backgroundColor = UIColor.hexStr("FEE360", alpha: 255)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}