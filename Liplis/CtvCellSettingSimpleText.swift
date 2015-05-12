//
//  CtvCellSettingSimpleText.swift
//  Liplis
//
//  Created by sachin on 2015/05/02.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellSettingSimpleText: UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    var lblTitle = UILabel();
    
    ///=============================
    ///ON/OFF
    var on : Bool! = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        lblTitle = UILabel(frame: CGRectMake(10, 5, 300, 15));
        lblTitle.text = "";
        lblTitle.font = UIFont.systemFontOfSize(20)
        self.addSubview(lblTitle);
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}