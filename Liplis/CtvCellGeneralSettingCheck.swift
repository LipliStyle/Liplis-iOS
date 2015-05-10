//
//  CtvCellGeneralSettingCheck.swift
//  Liplis
//
//  Created by kosuke on 2015/05/02.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellGeneralSettingCheck : UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    var parView : ViewSetting!
    
    
    ///=============================
    ///カスタムセル要素
    var lblTitle = UILabel();
    var lblContent = UILabel();
    var btnCheckBox = UIButton();
    
    ///=============================
    ///レイアウト情報
    var viewWidth : CGFloat! = 0
    
    ///=============================
    ///設定インデックス
    var settingIdx : Int! = 0
    
    ///=============================
    ///ON/OFF
    var on : Bool! = false
    
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
        lblTitle.font = UIFont.systemFontOfSize(16)
        self.addSubview(lblTitle);
        
        lblContent = UILabel(frame: CGRectMake(20, 24, 300, 15));
        lblContent.text = "";
        lblContent.font = UIFont.systemFontOfSize(10)
        self.addSubview(lblContent);
        
        //チェックボッックス
        btnCheckBox = UIButton()
        btnCheckBox.titleLabel?.font = UIFont.systemFontOfSize(12)
        btnCheckBox.frame = CGRectMake(0,0,32,32)
        btnCheckBox.layer.masksToBounds = true
        btnCheckBox.setTitle("", forState: UIControlState.Normal)
        btnCheckBox.addTarget(self, action: "onClickCheck:", forControlEvents: .TouchDown)
        btnCheckBox.setImage(UIImage(named: "checkOff.png"), forState: UIControlState.Normal)
        btnCheckBox.layer.cornerRadius = 3.0
        
        self.addSubview(btnCheckBox)
    }
    
    /*
    ビューを設定する
    */
    func setView(parView : ViewSetting)
    {
        self.parView = parView
    }
    
    /*
    要素の位置を調整する
    */
    func setSize(viewWidth : CGFloat)
    {
        self.viewWidth = viewWidth
        var locationY : CGFloat = CGFloat(viewWidth - 50 - 9)
        btnCheckBox.frame = CGRectMake(locationY, 6, 32, 32)
    }
    
    /*
    値をセットする
    */
    func setVal(settingIdx : Int, val : Int)
    {
        self.on = LiplisUtil.int2Bit(val)
        self.settingIdx = settingIdx
        if(self.on == true)
        {
            let imgOn : UIImage = UIImage(named: "checkOn.png")!
            btnCheckBox.setImage(imgOn, forState: UIControlState.Normal)
        }
        else
        {
            let imgOff : UIImage = UIImage(named: "checkOff.png")!
            btnCheckBox.setImage(imgOff, forState: UIControlState.Normal)
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
    func onClickCheck(sender: UIButton) {
        if(self.on == true)
        {
            println("チェックボックスOFF")
            let imgOff : UIImage = UIImage(named: "checkOff.png")!
            btnCheckBox.setImage(imgOff, forState: UIControlState.Normal)
            self.on = false
            self.parView.selectCheck(settingIdx,val: false)
        }
        else
        {
            println("チェックボックスON")
            let imgOn : UIImage = UIImage(named: "checkOn.png")!
            btnCheckBox.setImage(imgOn, forState: UIControlState.Normal)
            self.on = true
            self.parView.selectCheck(settingIdx,val: true)
        }
    }
}