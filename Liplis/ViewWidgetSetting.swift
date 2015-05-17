//
//  ViewWidgetSetting.swift
//  Liplis
//
//  Liplis ウィジェット設定
//
//アップデート履歴
//   2015/04/26 ver0.1.0 作成
//   2015/05/13 ver1.2.0 ログの送りバグ修正
//   2015/05/16 ver1.4.0　swift1.2対応
//                        リファクタリング
//
//  Created by sachin on 2015/04/26.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit

class ViewWidgetSetting :  UIViewController, UITableViewDelegate, UITableViewDataSource{
    ///=============================
    ///ウィジェットインスタンス
    private var widget : LiplisWidget!
    
    ///=============================
    ///テーブル要素
    private var tblItems : Array<MsgSettingViewCell>! = []
    
    ///=============================
    ///ビュータイトル
    private var viewTitle = "Liplis ウィジェット設定"
    
    ///=============================
    ///画面要素
    private var lblTitle : UILabel!
    private var btnBack : UIButton!
    private var tblSetting: UITableView!
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    /*
    コンストラクター
    */
    convenience init(widget : LiplisWidget) {
        self.init(nibName: nil, bundle: nil)
        self.widget = widget
        self.initView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    /*
    アクティビティの初期化
    */
    private func initView()
    {
        //ビューの初期化
        self.view.opaque = true                                                     //背景透過許可
        self.view.backgroundColor = UIColor(red:255,green:255,blue:255,alpha:255)   //白透明背景
        
        //タイトルラベルの作成
        self.createLblTitle()
        
        //閉じるボタン作成
        self.createBtnClose()
        
        //テーブル作成
        self.createTableView()
        
        //サイズ調整
        self.setSize()
    }
    
    /*
    タイトルラベルの初期化
    */
    private func createLblTitle()
    {
        self.lblTitle = UILabel(frame: CGRectMake(0,0,0,0))
        self.lblTitle.backgroundColor = UIColor.hexStr("ffa500", alpha: 255)
        self.lblTitle.text = self.viewTitle
        self.lblTitle.textColor = UIColor.whiteColor()
        self.lblTitle.shadowColor = UIColor.grayColor()
        self.lblTitle.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.lblTitle)
    }
    
    /*
    閉じるボタンの初期化
    */
    private func createBtnClose()
    {
        self.btnBack = UIButton()
        self.btnBack.titleLabel?.font = UIFont.systemFontOfSize(12)
        self.btnBack.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        self.btnBack.layer.masksToBounds = true
        self.btnBack.setTitle("閉じる", forState: UIControlState.Normal)
        self.btnBack.addTarget(self, action: "closeMe:", forControlEvents: .TouchDown)
        self.btnBack.layer.cornerRadius = 3.0
        self.view.addSubview(btnBack)
    }
    
    /*
    設定要素テーブルの初期化
    */
    private func createTableView()
    {
        //TableViewの生成
        self.tblSetting = UITableView()
        self.tblSetting.frame = CGRectMake(0,0,0,0)
        self.tblSetting.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.tblSetting.dataSource = self
        self.tblSetting.delegate = self
        self.tblSetting.allowsSelection = false
        self.tblSetting.rowHeight = 20
        self.tblSetting.registerClass(CtvCellSettingTitle.self, forCellReuseIdentifier: "CtvCellSettingTitle")
        self.tblSetting.registerClass(CtvCellSettingSwitch.self, forCellReuseIdentifier: "CtvCellSettingSwitch")
        self.tblSetting.registerClass(CtvCellSettingCheck.self, forCellReuseIdentifier: "CtvCellSettingCheck")
        self.tblSetting.registerClass(CtvCellSettingRadio.self, forCellReuseIdentifier: "CtvCellSettingRadio")
        self.view.addSubview(self.tblSetting)
        
        //テーブルビューアイテム作成
        self.tblItems = Array<MsgSettingViewCell>()
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "おしゃべりモード",
                content: "",partsType: LiplisDefine.PARTS_TYPE_TITLE,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        var lpsMode : MsgSettingViewCell = MsgSettingViewCell(
            title: "",
            content: "",
            partsType: LiplisDefine.PARTS_TYPE_RADIO,settingIdx: 3,
            initValue : widget.os.lpsMode,
            trueValue: 0,
            rowHeight: CGFloat(0)
        )
        lpsMode.appendChild(
            MsgSettingViewCell(
                title: "おしゃべり",
                content: "10秒おき",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 3,initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(45)
            )
        )
        lpsMode.appendChild(
            MsgSettingViewCell(
                title: "ふつう",
                content: "30秒おき",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 3,
                initValue : 0,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        lpsMode.appendChild(
            MsgSettingViewCell(
                title: "ひかえめ",
                content: "1分おき",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 3,initValue : 0,
                trueValue: 2,
                rowHeight: CGFloat(45)
            )
        )
        lpsMode.appendChild(
            MsgSettingViewCell(
                title: "無口",
                content: "自動発言なし",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 3,
                initValue : 0,
                trueValue: 3,
                rowHeight: CGFloat(45)
            )
        )
        self.tblItems.append(lpsMode)
        
        
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "アクティブ度",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        var lpsActive : MsgSettingViewCell =
        MsgSettingViewCell(
            title: "",
            content: "",
            partsType: LiplisDefine.PARTS_TYPE_RADIO,settingIdx: 5,
            initValue : widget.os.lpsSpeed,
            trueValue: 0,
            rowHeight: CGFloat(0)
        )
        lpsActive.appendChild(
            MsgSettingViewCell(
                title: "おてんば",
                content: "3倍速 よく動く",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 5,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(45)
            )
        )
        lpsActive.appendChild(
            MsgSettingViewCell(
                title: "ふつう",
                content: "2倍速 ふつう",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 5,
                initValue : 0,
                trueValue: 1,
                rowHeight: CGFloat(45)))
        lpsActive.appendChild(
            MsgSettingViewCell(
                title: "ゆっくり",
                content: "1倍速 ひかえめ",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 5,
                initValue : 0,
                trueValue: 2,
                rowHeight: CGFloat(45)
            )
        )
        self.tblItems.append(lpsActive)
        
        
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "アイコンの表示",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "常にアイコンを表示する",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_CHECK,settingIdx: 7,
                initValue : widget.os.lpsDisplayIcon,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "バッテリー残量シンクロ",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(title: "バッテリー残量に応じて状態変化させる",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_CHECK,
                settingIdx: 8,
                initValue : widget.os.lpsHealth,trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "ウインドウカラー",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        var lpsWindow : MsgSettingViewCell =
        MsgSettingViewCell(
            title: "",
            content: "",
            partsType: LiplisDefine.PARTS_TYPE_RADIO,settingIdx: 6,
            initValue : widget.os.lpsWindow,
            trueValue: 0,
            rowHeight: CGFloat(0)
        )
        lpsWindow.appendChild(
            MsgSettingViewCell(
                title: "ウインドウカラー1",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,settingIdx: 6,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(45)
            )
        )
        lpsWindow.appendChild(
            MsgSettingViewCell(
                title: "ウインドウカラー2",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,settingIdx: 6,
                initValue : 0,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        lpsWindow.appendChild(
            MsgSettingViewCell(
                title: "ウインドウカラー3",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 6,
                initValue : 0,
                trueValue: 2,
                rowHeight: CGFloat(45)
            )
        )
        lpsWindow.appendChild(
            MsgSettingViewCell(
                title: "ウインドウカラー4",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,settingIdx: 6,
                initValue : 0,
                trueValue: 3,
                rowHeight: CGFloat(45)
            )
        )
        lpsWindow.appendChild(
            MsgSettingViewCell(
                title: "ウインドウカラー5",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 6,
                initValue : 0,
                trueValue: 4,
                rowHeight: CGFloat(45)
            )
        )
        lpsWindow.appendChild(
            MsgSettingViewCell(
                title: "ウインドウカラー6",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,settingIdx: 6,
                initValue : 0,
                trueValue: 5,
                rowHeight: CGFloat(45)
            )
        )
        lpsWindow.appendChild(
            MsgSettingViewCell(
                title: "ウインドウカラー7",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 6,
                initValue : 0,
                trueValue: 6,
                rowHeight: CGFloat(45)
            )
        )
        self.tblItems.append(lpsWindow)
    }
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    ビュー呼び出し時
    */
    override func viewWillAppear(animated: Bool) {
        //サイズ設定
        self.setSize()
    }
    
    
    /*
    画面を閉じる
    */
    internal func closeMe(sender: AnyObject) {
        self.widget.setWindow()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    internal func tableView(tableView: UITableView, indexPath: NSIndexPath)->NSIndexPath? {
        println("Num: \(indexPath.row)")
        println("Value: \(tblItems[indexPath.row].title)")
        
        return nil;
    }
    
    /*
    Cellの総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("numberOfRowsInSection")
        return self.tblItems.count
    }
    
    /*
    Editableの状態にする.
    */
    internal func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        println("canEditRowAtIndexPath")
        
        return true
    }
    
    /*
    特定の行のボタン操作を有効にする.
    */
    internal func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        println("commitEdittingStyle:\(editingStyle)")
    }
    
    /*
    Cellに値を設定する.
    */
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("cellForRowAtIndexPath")
        return settingCell(indexPath)
    }
    
    
    /*
    セル設定
    */
    internal func settingCell(indexPath : NSIndexPath) -> UITableViewCell!
    {
        var cellSetting : MsgSettingViewCell = tblItems[indexPath.row]

        switch(cellSetting.partsType)
        {
        case 0://タイトル
            let cell : CtvCellSettingTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingTitle", forIndexPath: indexPath) as! CtvCellSettingTitle
            cell.lblTitle.text = cellSetting.title
            return cell
        case 1://チェックボタン
            let cell : CtvCellSettingCheck = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingCheck", forIndexPath: indexPath) as! CtvCellSettingCheck
            cell.setView(self)
            cell.lblTitle.text = cellSetting.title
            cell.lblContent.text = cellSetting.content
            cell.setSize(self.view.frame.width)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)
            return cell
        case 2://スイッチ
            let cell : CtvCellSettingSwitch = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingSwitch", forIndexPath: indexPath) as! CtvCellSettingSwitch
            cell.setView(self)
            cell.lblTitle.text = cellSetting.title
            cell.lblContent.text = cellSetting.content
            cell.setSize(self.view.frame.width)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)
            return cell
        case 3://ラジオボタン
            let cell : CtvCellSettingRadio = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingRadio", forIndexPath: indexPath) as! CtvCellSettingRadio
            cell.setView(self)
            cell.setRadio(self.view.frame.width, childList: cellSetting.childList)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)

            return cell
        default:
            let cell = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingCheck", forIndexPath: indexPath) as! CtvCellSettingCheck
            cell.lblTitle.text = cellSetting.title
            cell.lblContent.text = cellSetting.content
            cell.setVal(1,val: 1)
            cell.setSize(self.view.frame.width)
            return cell
        }
    }
    
    internal func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        println("estimatedHeightForRowAtIndexPath" + String(indexPath.row))
        return CGFloat(30)
    }
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        println("estimatedHeightForRowAtIndexPath" + String(indexPath.row))
        var cellSetting : MsgSettingViewCell = tblItems[indexPath.row]
        
        return cellSetting.rowHeight
    }
    
    /*
    チェックとスイッチの操作
    */
    internal func selectCheck(settingIdx : Int, val : Bool)
    {
        println("チェック選択 idx:" + String(settingIdx) + " val:" + String(LiplisUtil.bit2Int(val)))
        self.widget.os.saveDataFromIdx(settingIdx, val: LiplisUtil.bit2Int(val))
    }
    internal func selectVal(settingIdx : Int, val : Int)
    {
        println("ラジオ選択 idx:" + String(settingIdx) + " val:" + String(val))
        self.widget.os.saveDataFromIdx(settingIdx, val: val)
    }
    
    //============================================================
    //
    //アクティビティ操作
    //
    //============================================================
    
    /*
    サイズ設定
    */
    private func setSize()
    {
        // 現在のデバイスの向きを取得.
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.currentDevice().orientation
        
        // 向きの判定.
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            //横向きの判定
            
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            //縦向きの判定
        }
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        self.lblTitle.frame = CGRectMake(0, 0, displayWidth, LiplisDefine.labelHight)
        self.btnBack.frame = CGRectMake(self.lblTitle.frame.origin.x + 5,self.lblTitle.frame.origin.y + 25, displayWidth/6, 30)
        self.tblSetting.frame = CGRectMake(0, self.lblTitle.frame.height, displayWidth, displayHeight - self.lblTitle.frame.height)
        
        //テーブルのリロード
        self.tblSetting.reloadData()
    }
    
    
    
    //============================================================
    //
    //回転ハンドラ
    //
    //============================================================
    /*
    画面の向き変更時イベント
    */
    internal override func viewDidAppear(animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onOrientationChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    internal func onOrientationChange(notification: NSNotification){
        self.setSize()
    }
    
}
