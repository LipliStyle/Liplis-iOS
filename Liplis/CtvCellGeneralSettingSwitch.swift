//
//  CtvCellGeneralSettingSwitch.swift
//  Liplis
//
//設定画面 要素 スイッチ
//
//アップデート履歴
//   2015/05/02 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　リファクタリング
//
//  Created by sachin on 2015/05/02.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellGeneralSettingSwitch: UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    internal var parView : ViewSetting!
    
    ///=============================
    ///カスタムセル要素
    internal var lblTitle = UILabel();
    internal var lblContent = UILabel();
    internal var switchSelect = UISwitch();
    
    ///=============================
    ///レイアウト情報
    internal var viewWidth : CGFloat! = 0
    
    ///=============================
    ///設定インデックス
    internal var settingIdx : Int! = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    internal override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.lblTitle = UILabel(frame: CGRectMake(20, 5, 300, 15));
        self.lblTitle.text = "";
        self.lblTitle.font = UIFont.systemFontOfSize(16)
        self.addSubview(self.lblTitle);
        
        self.lblContent = UILabel(frame: CGRectMake(20, 22, 300, 15));
        self.lblContent.text = "";
        self.lblContent.font = UIFont.systemFontOfSize(10)
        self.addSubview(self.lblContent);
        
        //スイッチ
        self.switchSelect = UISwitch()
        self.switchSelect.frame = CGRectMake(200, 6, 50, 15)
        self.switchSelect.tintColor = UIColor.blackColor()
        self.switchSelect.on = LiplisUtil.int2Bit(1)
        self.switchSelect.addTarget(self, action: "onClickSelectSwitc:", forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(self.switchSelect)
    }
    
    /*
    ビューを設定する
    */
    internal func setView(parView : ViewSetting)
    {
        self.parView = parView
    }
    
    /*
    要素の位置を調整する
    */
    internal func setSize(viewWidth : CGFloat)
    {
        self.viewWidth = viewWidth
        let locationY : CGFloat = CGFloat(viewWidth - 50 - 20)
        self.switchSelect.frame = CGRectMake(locationY, 6, 50, 15)
    }
    
    /*
    値をセットする
    */
    internal func setVal(settingIdx : Int, val : Int)
    {
        self.switchSelect.on = LiplisUtil.int2Bit(val)
        self.settingIdx = settingIdx
    }
    
    required init?(coder aDecoder: NSCoder)
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
    internal func onClickSelectSwitc(sender: UISwitch) {
        self.parView.selectCheck(settingIdx, val: self.switchSelect.on)
    }
}