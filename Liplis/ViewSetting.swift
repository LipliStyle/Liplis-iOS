//
//  ViewSetting.swift
//  Liplis
//
//  Liplisの全体にかかわる設定を行う画面
//
//
//アップデート履歴
//   2015/04/19 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/14 ver1.3.0　リファクタリング
//   2015/05/16 ver1.4.0　swift1.2対応
//
//  Created by sachin on 2015/04/19.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit

class ViewSetting :  UIViewController, UITableViewDelegate, UITableViewDataSource{
    ///=============================
    ///テーブル要素
    private var tblItems : Array<MsgSettingViewCell>! = []
    
    //=================================
    //リプリスベース設定
    private var baseSetting : LiplisPreference!
    
    ///=============================
    ///ビュータイトル
    private var viewTitle = "Liplis設定"
    
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
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        //クラスの初期化
        self.initClass()
        
        //ビューの初期化
        self.initView()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
        クラスの初期化
    */
    private func initClass()
    {
        self.baseSetting = LiplisPreference.SharedInstance
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
        //戻るボタン
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
        self.tblSetting.registerClass(CtvCellGeneralSettingTitle.self, forCellReuseIdentifier: "CtvCellGeneralSettingTitle")
        self.tblSetting.registerClass(CtvCellGeneralSettingSwitch.self, forCellReuseIdentifier: "CtvCellGeneralSettingSwitch")
        self.tblSetting.registerClass(CtvCellGeneralSettingCheck.self, forCellReuseIdentifier: "CtvCellGeneralSettingCheck")
        self.tblSetting.registerClass(CtvCellGeneralSettingRadio.self, forCellReuseIdentifier: "CtvCellGeneralSettingRadio")
        self.view.addSubview(self.tblSetting)
        
        //テーブルビューアイテム作成
        self.tblItems = Array<MsgSettingViewCell>()
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "オートスリープ",
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
                title: "画面OFF時、自動的におやすみする",content: "",
                partsType: LiplisDefine.PARTS_TYPE_CHECK,
                settingIdx: 1,
                initValue : baseSetting.lpsAutoSleep,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "オートウェイクアップ",
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
                title: "画面ON時、自動的におきる",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_CHECK,settingIdx: 2,
                initValue : baseSetting.lpsAutoWakeup,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "移動範囲設定",
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
                title: "画面外に出た時自動的に戻す",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_CHECK,
                settingIdx: 3,
                initValue : baseSetting.lpsAutoRescue,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "トークウインドウモード",
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
                title: "トークウインドウクリック時、記事にジャンプする",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_CHECK,settingIdx: 4,
                initValue : baseSetting.lpsTalkWindowClickMode,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "ブラウザモード",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        var lpsBrowserMode : MsgSettingViewCell = MsgSettingViewCell(
            title: "",
            content: "",
            partsType: LiplisDefine.PARTS_TYPE_RADIO,
            settingIdx: 5,
            initValue : baseSetting.lpsBrowserMode,
            trueValue: 0,
            rowHeight: CGFloat(0)
        )
        lpsBrowserMode.appendChild(
            MsgSettingViewCell(
                title: "Liplisブラウザ",
                content: "アプリ内ブラウザで記事を開きます。",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 5,initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(45)
            )
        )
        lpsBrowserMode.appendChild(
            MsgSettingViewCell(
                title: "Safari",
                content: "サファリで開きます。",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 5,
                initValue : 0,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        self.tblItems.append(lpsBrowserMode)
    }
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    internal override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    ビュー呼び出し時
    */
    internal override func viewWillAppear(animated: Bool) {
        //サイズ設定
        setSize()
    }
    
    
    /*
    画面を閉じる
    */
    internal func closeMe(sender: AnyObject) {
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
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("numberOfRowsInSection")
        return tblItems.count
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
            let cell : CtvCellGeneralSettingTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellGeneralSettingTitle", forIndexPath: indexPath) as! CtvCellGeneralSettingTitle
            cell.lblTitle.text = cellSetting.title
            return cell
        case 1://チェックボタン
            let cell : CtvCellGeneralSettingCheck = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellGeneralSettingCheck", forIndexPath: indexPath) as!CtvCellGeneralSettingCheck
            cell.setView(self)
            cell.lblTitle.text = cellSetting.title
            cell.lblContent.text = cellSetting.content
            cell.setSize(self.view.frame.width)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)
            return cell
        case 2://スイッチ
            let cell : CtvCellGeneralSettingSwitch = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellGeneralSettingSwitch", forIndexPath: indexPath) as!CtvCellGeneralSettingSwitch
            cell.setView(self)
            cell.lblTitle.text = cellSetting.title
            cell.lblContent.text = cellSetting.content
            cell.setSize(self.view.frame.width)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)
            return cell
        case 3://ラジオボタン
            let cell : CtvCellGeneralSettingRadio = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellGeneralSettingRadio", forIndexPath: indexPath) as!CtvCellGeneralSettingRadio
            cell.setView(self)
            cell.setRadio(self.view.frame.width, childList: cellSetting.childList)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)
            
            return cell
        default:
            let cell : CtvCellGeneralSettingTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellGeneralSettingTitle", forIndexPath: indexPath) as! CtvCellGeneralSettingTitle
            cell.lblTitle.text = cellSetting.title
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
        baseSetting.saveDataFromIdx(settingIdx, val: LiplisUtil.bit2Int(val))
        setTblItems(settingIdx, val: LiplisUtil.bit2Int(val))
    }
    internal func selectVal(settingIdx : Int, val : Int)
    {
        println("ラジオ選択 idx:" + String(settingIdx) + " val:" + String(val))
        baseSetting.saveDataFromIdx(settingIdx, val: val)
        setTblItems(settingIdx, val: val)
    }
    internal func setTblItems(settingIdx : Int, val : Int)
    {
        for msg : MsgSettingViewCell in tblItems
        {
            if msg.settingIdx == settingIdx
            {
                msg.initValue = val
            }
        }
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
        // 現在のデバイスの向きを取得
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.currentDevice().orientation
        
        //方向別の処理
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
    override func viewDidAppear(animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onOrientationChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    internal func onOrientationChange(notification: NSNotification){
        setSize()
    }
    
}