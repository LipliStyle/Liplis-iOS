//
//  ViewWidgetMenu.swift
//  Liplis
//
//  Liplis ウィジェット設定メニュー
//
//アップデート履歴
//   2015/05/05 ver0.1.0 作成
//   2015/05/13 ver1.2.0 ログの送りバグ修正
//   2015/05/16 ver1.4.0　swift1.2対応
//                        リファクタリング
//
//  Created by sachin on 2015/05/05.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit

class ViewWidgetMenu :  UIViewController, UITableViewDelegate, UITableViewDataSource{
    ///=============================
    ///ウィジェットインスタンス
    internal var widget : LiplisWidget!
    
    ///=============================
    ///テーブル要素
    private var tblItems : Array<MsgSettingViewCell>! = []
    
    ///=============================
    ///ビュータイトル
    private var viewTitle = "Liplisウィジェットメニュー"
    
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
        self.initClass()
        self.initView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    /*
    クラスの初期化
    */
    private func initClass()
    {
        
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
        self.tblSetting = UITableView()
        self.tblSetting.frame = CGRectMake(0,0,0,0)
        self.tblSetting.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.tblSetting.dataSource = self
        self.tblSetting.delegate = self
        self.tblSetting.allowsSelection = false
        self.tblSetting.rowHeight = 20
        self.tblSetting.registerClass(CtvCellWidgetMenuTitle.self, forCellReuseIdentifier: "CtvCellWidgetMenuTitle")
        self.tblSetting.registerClass(CtvCellWidgetIntoroduction.self, forCellReuseIdentifier: "CtvCellWidgetIntoroduction")
        self.tblSetting.registerClass(CtvCellWidgetController.self, forCellReuseIdentifier: "CtvCellWidgetController")
        self.tblSetting.registerClass(CtvCellWidgetSetting.self, forCellReuseIdentifier: "CtvCellWidgetSetting")
        self.tblSetting.registerClass(CtvCellWidgetTopicSetting.self, forCellReuseIdentifier: "CtvCellWidgetTopicSetting")
        self.view.addSubview(self.tblSetting)
        
        //テーブルビューアイテム作成
        self.tblItems = Array<MsgSettingViewCell>()
        self.tblItems.append(
            MsgSettingViewCell(
                title: "リプリスウィジェット設定",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "",
                content: "",
                partsType: 1,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(100)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "ウィジェット操作",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "",
                content: "",
                partsType: 2,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(60)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "ウィジェット動作設定",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "",
                content: "",
                partsType: 3,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(60)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "話題設定",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1
                ,initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "",
                content: "",
                partsType: 4,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(60)
            )
        )

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
        self.setSize()
    }
    
    
    /*
    画面を閉じる
    */
    func closeMe(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    func tableView(tableView: UITableView, indexPath: NSIndexPath)->NSIndexPath? {
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
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        println("canEditRowAtIndexPath")
        
        return true
    }
    
    /*
    特定の行のボタン操作を有効にする.
    */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        println("commitEdittingStyle:\(editingStyle)")
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("cellForRowAtIndexPath")
        return self.settingCell(indexPath)
    }
    
    
    /*
    セル設定
    */
    func settingCell(indexPath : NSIndexPath) -> UITableViewCell!
    {
        var cellSetting : MsgSettingViewCell = tblItems[indexPath.row]
        
        switch(cellSetting.partsType)
        {
        case 0://タイトル
            let cell : CtvCellWidgetMenuTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellWidgetMenuTitle", forIndexPath: indexPath) as! CtvCellWidgetMenuTitle
            cell.lblTitle.text = cellSetting.title
            return cell
        case 1://説明セクション
            let cell : CtvCellWidgetIntoroduction = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellWidgetIntoroduction", forIndexPath: indexPath)as! CtvCellWidgetIntoroduction
            cell.sSetImage(widget.lpsSkinData.imgIco)
            return cell
        case 2://ウィジェット操作画面
            let cell : CtvCellWidgetController = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellWidgetController", forIndexPath: indexPath) as! CtvCellWidgetController
            cell.setView(self)
            cell.setSize(self.view.frame.width)
            return cell
        case 3://動作設定
            let cell : CtvCellWidgetSetting = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellWidgetSetting", forIndexPath: indexPath) as! CtvCellWidgetSetting
            cell.setView(self, widget: widget)
            cell.setSize(self.view.frame.width)
            return cell
        case 4://話題画面
            let cell : CtvCellWidgetTopicSetting = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellWidgetTopicSetting", forIndexPath: indexPath) as! CtvCellWidgetTopicSetting
            cell.setView(self)
            cell.setSize(self.view.frame.width)
            return cell
        default:
            let cell : CtvCellMenuTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuTitle", forIndexPath: indexPath) as! CtvCellMenuTitle
            cell.lblTitle.text = cellSetting.title
            return cell
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        println("estimatedHeightForRowAtIndexPath" + String(indexPath.row))
        return CGFloat(30)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        println("estimatedHeightForRowAtIndexPath" + String(indexPath.row))
        var cellSetting : MsgSettingViewCell = self.tblItems[indexPath.row]
        
        return cellSetting.rowHeight
    }
    
    /*
    ボタン操作
    */
    func widgetNext()
    {
        self.widget.onClickBody()
        dismissViewControllerAnimated(true, completion: nil)
    }
    func widgetBattery()
    {
        self.widget.batteryInfo()
        dismissViewControllerAnimated(true, completion: nil)
    }
    func widgetClock()
    {
        self.widget.clockInfo()
        dismissViewControllerAnimated(true, completion: nil)
    }
    func widgetSleep()
    {
        self.widget.onClickSleep()
        dismissViewControllerAnimated(true, completion: nil)
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
