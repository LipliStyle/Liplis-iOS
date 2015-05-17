//
//  CtvCellWidgetIntoroduction.swift
//  Liplis
//
//  Created by sachin on 2015/05/05.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellWidgetIntoroduction: UITableViewCell
{
    ///=============================
    ///親画面インスタンス
    var parView : ViewWidgetMenu!
    
    ///=============================
    ///カスタムセル要素
    var lblIntoroduction : UILabel!
    var imgChar: UIImageView!
    
    /*
    ビューを設定する
    */
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //キャラクターイメージ設定
        imgChar = UIImageView(frame: CGRectMake(4,5,96,96))
        self.addSubview(imgChar);
        
        //ラベル設定
        lblIntoroduction = UILabel(frame: CGRectMake(imgChar.frame.origin.x + imgChar.frame.width + 5, 5, 300, 96));
        lblIntoroduction.numberOfLines = 4
        lblIntoroduction.text = "ウィジェットの設定メニューです。\nウィジェットごとの話題、動作の設定を\n行うことができます。";
        lblIntoroduction.font = UIFont.systemFontOfSize(12)
        
        self.addSubview(lblIntoroduction);
    }
    
    /*
    イメージを設定する
    */
    func sSetImage(img : UIImage)
    {
        imgChar.image = img
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
