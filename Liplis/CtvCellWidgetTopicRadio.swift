//
//  CtvCellWidgetTopicRadio.swift
//  Liplis
//
//ウィジェット話題設定画面 要素 ラジオボタン
//
//アップデート履歴
//   2015/05/05 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　リファクタリング
//
//  Created by sachin on 2015/05/05.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class CtvCellWidgetTopicRadio : UITableViewCell
{
    ///=============================
    ///カスタムセル要素
    internal var parView : ViewWidgetTopicSetting!
    internal var childList : Array<MsgSettingViewCell>! = []
    
    ///=============================
    ///イメージ
    internal var imgOn : UIImage!
    internal var imgOff : UIImage!
    
    ///=============================
    ///レイアウト情報
    internal var viewWidth : CGFloat! = 0
    internal var flgInit : Bool = false
    
    ///=============================
    ///設定インデックス
    internal var settingIdx : Int! = -1
    
    ///=============================
    ///設定値
    internal var val : Int! = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    internal override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.imgOn = UIImage(named: ObjR.imgRadioOn)!
        self.imgOff = UIImage(named: ObjR.imgRadioOff)!
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    /*
    ビューを設定する
    */
    internal func setView(parView : ViewWidgetTopicSetting)
    {
        self.parView = parView
    }

    /*
    要素の位置を調整する
    */
    internal func setRadio(viewWidth : CGFloat, childList : Array<MsgSettingViewCell>)
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
            for (parts: UIView) in views as! [UIView]
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
    internal func initCell()
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
            btnCheckBox.setImage(UIImage(named: ObjR.imgRadioOff), forState: UIControlState.Normal)
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
    internal func setVal(settingIdx : Int,val : Int)
    {
        self.val = val
        self.settingIdx = settingIdx
        
        var idx : Int = 0
        
        for hashVal in childList
        {
            let views = self.contentView.subviews
            for (parts: UIView) in views as! [UIView]
            {
                if(parts.hash == hashVal.hash)
                {
                    var uiv = parts as! UIButton
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
    internal func onClickCheck(sender: UIButton) {
        println("チェックボックスON")
        var idx : Int = 0
        
        
        for hashVal in childList
        {
            let views = self.contentView.subviews
            for (parts: UIView) in views as! [UIView]
            {
                if(parts.hash == hashVal.hash)
                {
                    var uiv = parts as! UIButton
                    
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