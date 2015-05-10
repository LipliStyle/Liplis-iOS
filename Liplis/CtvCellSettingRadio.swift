//
//  CtvCellSettingRadio.swift
//  Liplis
//
//  Created by kosuke on 2015/05/01.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellSettingRadio : UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    var parView : ViewWidgetSetting!
    var childList : Array<MsgSettingViewCell>! = []

    ///=============================
    ///イメージ
    let imgOn : UIImage!
    let imgOff : UIImage!
    
    ///=============================
    ///レイアウト情報
    var viewWidth : CGFloat! = 0
    var flgInit : Bool = false
    
    ///=============================
    ///設定インデックス
    var settingIdx : Int! = -1
    
    ///=============================
    ///設定値
    var val : Int! = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgOn = UIImage(named: "radioOn.png")!
        imgOff = UIImage(named: "radioOff.png")!
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
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
    func setRadio(viewWidth : CGFloat, childList : Array<MsgSettingViewCell>)
    {
        self.viewWidth = viewWidth
        
        var baseLocationY : CGFloat = 5
        var checkBoxLocationX : CGFloat = CGFloat(viewWidth - 50 - 9)
        var idx : Int = 0
        
        //初期化されていない場合は初期化する
        if(!flgInit)
        {
            self.childList = childList
            initCell()
        }

        //位置調整
        for hashVal in childList
        {
            baseLocationY = CGFloat(5 + idx * 45)
            
            let views = self.subviews
            for (parts: UIView) in views as [UIView]
            {
                //対象ウィジェットのパーツだった場合、位置調整する
                if(parts.hash == hashVal.hash)
                {
                    parts.frame = CGRectMake(checkBoxLocationX,baseLocationY + 1,32,32)
                }
            }
            idx++
        }
    }
    
    /*
    セルの初期化
    */
    func initCell()
    {
        var baseLocationY : CGFloat = 5
        var checkBoxLocationX : CGFloat = CGFloat(self.viewWidth - 50 - 9)
        var idx : Int = 0
        
        for msg : MsgSettingViewCell in childList
        {
            baseLocationY = CGFloat(5 + idx * 45)
            var lblTitle = UILabel();
            var lblContent = UILabel();
            var btnCheckBox = UIButton();
            
            lblTitle = UILabel(frame: CGRectMake(40, baseLocationY, 300, 15));
            lblTitle.text = msg.title;
            lblTitle.font = UIFont.systemFontOfSize(20)
            self.contentView.addSubview(lblTitle);
            
            lblContent = UILabel(frame: CGRectMake(40, baseLocationY + 19, 300, 15));
            lblContent.text = msg.content;
            lblContent.font = UIFont.systemFontOfSize(10)
            self.contentView.addSubview(lblContent);
            
            //チェックボッックス
            btnCheckBox = UIButton()
            btnCheckBox.titleLabel?.font = UIFont.systemFontOfSize(12)
            btnCheckBox.frame = CGRectMake(checkBoxLocationX,baseLocationY + 1,32,32)
            btnCheckBox.layer.masksToBounds = true
            btnCheckBox.setTitle("", forState: UIControlState.Normal)
            btnCheckBox.addTarget(self, action: "onClickCheck:", forControlEvents: .TouchDown)
            btnCheckBox.setImage(UIImage(named: "radioOff.png"), forState: UIControlState.Normal)
            btnCheckBox.layer.cornerRadius = 3.0
            childList[idx].hash = btnCheckBox.hash
            self.contentView.addSubview(btnCheckBox)
            
            idx++
        }
        
        flgInit = true
    }
    
    /*
    ラジオボタンに値を設定する
    */
    func setVal(settingIdx : Int,val : Int)
    {
        self.val = val
        self.settingIdx = settingIdx
        
        var idx : Int = 0
        
        for hashVal in childList
        {
            let views = self.contentView.subviews
            for (parts: UIView) in views as [UIView]
            {
                if(parts.hash == hashVal.hash)
                {
                    var uiv = parts as UIButton
                    if hashVal.trueValue == val
                    {
                        uiv.setImage(self.imgOn, forState: UIControlState.Normal)
                    }
                    else
                    {
                        uiv.setImage(self.self.imgOff, forState: UIControlState.Normal)
                    }
                }
            }
            idx++
        }
    }
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    /*
    クリックイベント
    */
    func onClickCheck(sender: UIButton) {
        println("チェックボックスON")
        var idx : Int = 0
        
        
        for hashVal in childList
        {
            let views = self.contentView.subviews
            for (parts: UIView) in views as [UIView]
            {
                if(parts.hash == hashVal.hash)
                {
                    var uiv = parts as UIButton
                    
                    //選択ボタンの場合
                    if parts.hash == sender.hash
                    {
                        self.val = childList[idx].trueValue
                        uiv.setImage(self.imgOn, forState: UIControlState.Normal)
                    }
                    else
                    {
                        uiv.setImage(self.self.imgOff, forState: UIControlState.Normal)

                    }
                }
            }
            idx++
        }
        
        //値を設定
        self.parView.selectVal(self.settingIdx, val: self.val)
    }
}