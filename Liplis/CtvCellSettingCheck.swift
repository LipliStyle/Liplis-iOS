//
//  CtvCellSettingCheck.swift
//  Liplis
//
//ウィジェット設定画面 要素 チェックボックス
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
class CtvCellSettingCheck : UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    internal var parView : ViewWidgetSetting!

    
    ///=============================
    ///カスタムセル要素
    internal var lblTitle = UILabel();
    internal var lblContent = UILabel();
    internal var btnCheckBox = UIButton();
    
    ///=============================
    ///レイアウト情報
    var viewWidth : CGFloat! = 0

    ///=============================
    ///設定インデックス
    internal var settingIdx : Int! = 0
    
    ///=============================
    ///ON/OFF
    internal var on : Bool! = false
    
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
        self.lblTitle.font = UIFont.systemFontOfSize(20)
        self.addSubview(self.lblTitle);
        
        self.lblContent = UILabel(frame: CGRectMake(20, 24, 300, 15));
        self.lblContent.text = "";
        self.lblContent.font = UIFont.systemFontOfSize(10)
        self.addSubview(self.lblContent);
        
        //チェックボッックス
        self.btnCheckBox = UIButton()
        self.btnCheckBox.titleLabel?.font = UIFont.systemFontOfSize(12)
        self.btnCheckBox.frame = CGRectMake(0,0,32,32)
        self.btnCheckBox.layer.masksToBounds = true
        self.btnCheckBox.setTitle("", forState: UIControlState.Normal)
        self.btnCheckBox.addTarget(self, action: "onClickCheck:", forControlEvents: .TouchDown)
        self.btnCheckBox.setImage(UIImage(named: "checkOff.png"), forState: UIControlState.Normal)
        self.btnCheckBox.layer.cornerRadius = 3.0
        
        self.addSubview(self.btnCheckBox)
    }
    
    /*
    ビューを設定する
    */
    internal func setView(parView : ViewWidgetSetting)
    {
        self.parView = parView
    }
    
    /*
    要素の位置を調整する
    */
    internal func setSize(viewWidth : CGFloat)
    {
        self.viewWidth = viewWidth
        var locationY : CGFloat = CGFloat(viewWidth - 50 - 9)
        self.btnCheckBox.frame = CGRectMake(locationY, 6, 32, 32)
    }
    
    /*
    値をセットする
    */
    internal func setVal(settingIdx : Int, val : Int)
    {
        self.on = LiplisUtil.int2Bit(val)
        self.settingIdx = settingIdx
        if(self.on == true)
        {
            let imgOn : UIImage = UIImage(named: "checkOn.png")!
            self.btnCheckBox.setImage(imgOn, forState: UIControlState.Normal)
        }
        else
        {
            let imgOff : UIImage = UIImage(named: "checkOff.png")!
            self.btnCheckBox.setImage(imgOff, forState: UIControlState.Normal)
        }
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
    internal func onClickCheck(sender: UIButton) {
        if(self.on == true)
        {
            println("チェックボックスOFF")
            let imgOff : UIImage = UIImage(named: "checkOff.png")!
            self.btnCheckBox.setImage(imgOff, forState: UIControlState.Normal)
            self.on = false
            self.parView.selectCheck(self.settingIdx,val: false)
        }
        else
        {
            println("チェックボックスON")
            let imgOn : UIImage = UIImage(named: "checkOn.png")!
            self.btnCheckBox.setImage(imgOn, forState: UIControlState.Normal)
            self.on = true
            self.parView.selectCheck(self.settingIdx,val: true)
        }
    }
}