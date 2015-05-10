//
//  CtvCellSettingSwitch.swift
//  Liplis
//
//  Created by kosuke on 2015/05/01.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellSettingSwitch: UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    var parView : ViewWidgetSetting!

    ///=============================
    ///カスタムセル要素
    var lblTitle = UILabel();
    var lblContent = UILabel();
    var switchSelect = UISwitch();
    
    ///=============================
    ///レイアウト情報
    var viewWidth : CGFloat! = 0
    
    ///=============================
    ///設定インデックス
    var settingIdx : Int! = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        lblTitle = UILabel(frame: CGRectMake(20, 5, 300, 15));
        lblTitle.text = "";
        lblTitle.font = UIFont.systemFontOfSize(20)
        self.addSubview(lblTitle);
        
        lblContent = UILabel(frame: CGRectMake(20, 22, 300, 15));
        lblContent.text = "";
        lblContent.font = UIFont.systemFontOfSize(10)
        self.addSubview(lblContent);
        
        //スイッチ
        switchSelect = UISwitch()
        switchSelect.frame = CGRectMake(200, 6, 50, 15)
        switchSelect.tintColor = UIColor.blackColor()
        switchSelect.on = LiplisUtil.int2Bit(1)
        switchSelect.addTarget(self, action: "onClickSelectSwitc:", forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(switchSelect)
    }
    
    /*
    ビューを設定する
    */
    func setView(parView : ViewWidgetSetting)
    {
        self.parView = parView
    }
    
    /*
    要素の位置を調整する
    */
    func setSize(viewWidth : CGFloat)
    {
        self.viewWidth = viewWidth
        var locationY : CGFloat = CGFloat(viewWidth - 50 - 20)
        switchSelect.frame = CGRectMake(locationY, 6, 50, 15)
    }
    
    /*
    値をセットする
    */
    func setVal(settingIdx : Int, val : Int)
    {
        self.switchSelect.on = LiplisUtil.int2Bit(val)
        self.settingIdx = settingIdx
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    /*
    スイッチ選択
    */
    func onClickSelectSwitc(sender: UISwitch) {
        self.parView.selectCheck(settingIdx, val: self.switchSelect.on)
    }
}