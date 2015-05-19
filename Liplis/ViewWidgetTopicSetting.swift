//
//  ViewWidgetTopicSetting.swift
//  Liplis
//
//  Liplis ウィジェット話題設定
//
//アップデート履歴
//   2015/05/05 ver0.1.0 作成
//   2015/05/13 ver1.2.0 ログの送りバグ修正
//   2015/05/16 ver1.4.0　swift1.2対応
//                        リファクタリング
//   2015/05/19 ver1.4.1　話題2ch１を凍結
//
//  Created by sachin on 2015/05/05.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit

class ViewWidgetTopicSetting :  UIViewController, UITableViewDelegate, UITableViewDataSource{
    ///=============================
    ///ウィジェットインスタンス
    private var widget : LiplisWidget!
    
    ///=============================
    ///テーブル要素
    private var tblItems : Array<MsgSettingViewCell>! = []

    ///=============================
    ///ビュータイトル
    private var viewTitle = "話題設定"
    
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
        self.tblSetting.registerClass(CtvCellWidgetTopicTitle.self, forCellReuseIdentifier: "CtvCellWidgetTopicTitle")
        self.tblSetting.registerClass(CtvCellWidgetTopicCheck.self, forCellReuseIdentifier: "CtvCellWidgetTopicCheck")
        self.tblSetting.registerClass(CtvCellWidgetTopicRadio.self, forCellReuseIdentifier: "CtvCellWidgetTopicRadio")
        self.view.addSubview(tblSetting)
        
        //テーブルビューアイテム作成
        self.tblItems = Array<MsgSettingViewCell>()
        self.tblItems.append(
            MsgSettingViewCell(
                title: "おしゃべりジャンル",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "ニュース",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_CHECK,settingIdx: 12,
                initValue : widget.os.lpsTopicNews,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        //1.4.1  2chは一時的に凍結
//        self.tblItems.append(
//            MsgSettingViewCell(
//                title: "2ch",
//                content: "",
//                partsType: LiplisDefine.PARTS_TYPE_CHECK,
//                settingIdx: 13,
//                initValue : widget.os.lpsTopic2ch,
//                trueValue: 1,
//                rowHeight: CGFloat(45)
//            )
//        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "ニコニコ",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_CHECK,
                settingIdx: 14,
                initValue : widget.os.lpsTopicNico,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
//        self.tblItems.append(
//            MsgSettingViewCell(
//                title: "RSS",
//                content: "",
//                partsType: LiplisDefine.PARTS_TYPE_CHECK,
//                settingIdx: 15,
//                initValue : widget.os.lpsTopicRss,
//                trueValue: 1,
//                rowHeight: CGFloat(45)
//            )
//        )
//        self.tblItems.append(
//            MsgSettingViewCell(
//                title: "Twitter マイタイムライン",
//                content: "",
//                partsType: LiplisDefine.PARTS_TYPE_CHECK,
//                settingIdx: 18,
//                initValue : widget.os.lpsTopicTwitterMy,
//                trueValue: 1,
//                rowHeight: CGFloat(45)
//            )
//        )
//        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "Twitter パブリックタイムライン",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_CHECK,settingIdx: 17,
                initValue : widget.os.lpsTopicTwitterPu,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
//        self.tblItems.append(
//            MsgSettingViewCell(
//                title: "Twitter 設定ユーザーツイート",
//                content: "",
//                partsType: LiplisDefine.PARTS_TYPE_CHECK,
//                settingIdx: 16,
//                initValue : widget.os.lpsTopicTwitter,
//                trueValue: 1,
//                rowHeight: CGFloat(45)
//            )
//        )
        
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "話題の取得範囲",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        var lpsNewsRange : MsgSettingViewCell = MsgSettingViewCell(
            title: "",
            content: "",
            partsType: LiplisDefine.PARTS_TYPE_RADIO,
            settingIdx: 9,
            initValue : widget.os.lpsNewsRange,
            trueValue: 0,
            rowHeight: CGFloat(0)
        )
        lpsNewsRange.appendChild(
            MsgSettingViewCell(
                title: "1時間",
                content: "",partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 9,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(45)
            )
        )
        lpsNewsRange.appendChild(
            MsgSettingViewCell(
                title: "3時間",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 9,
                initValue : 0,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        lpsNewsRange.appendChild(
            MsgSettingViewCell(
                title: "6時間",content: "",partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,settingIdx: 9,initValue : 0, trueValue: 2, rowHeight: CGFloat(45)
            )
        )
        lpsNewsRange.appendChild(
            MsgSettingViewCell(
                title: "12時間",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,settingIdx: 9,
                initValue : 0,
                trueValue: 3,
                rowHeight: CGFloat(45)))
        lpsNewsRange.appendChild(MsgSettingViewCell(
            title: "1日",
            content: "",
            partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,settingIdx: 9,
            initValue : 0,
            trueValue: 4,
            rowHeight: CGFloat(45)
            )
        )
        lpsNewsRange.appendChild(
            MsgSettingViewCell(
                title: "3日",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 9,
                initValue : 0,
                trueValue: 5,
                rowHeight: CGFloat(45)
            )
        )
        lpsNewsRange.appendChild(
            MsgSettingViewCell(
                title: "7日",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,settingIdx: 9,
                initValue : 0,
                trueValue: 6,
                rowHeight: CGFloat(45)
            )
        )
        lpsNewsRange.appendChild(
            MsgSettingViewCell(
                title: "無制限",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 9,
                initValue : 0,
                trueValue: 7,
                rowHeight: CGFloat(45)
            )
        )
        self.tblItems.append(lpsNewsRange)
        
        
        self.tblItems.append(
            MsgSettingViewCell(
                title: "既読の話題設定",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        self.tblItems.append(
            MsgSettingViewCell(
                title: "既読の話題はおしゃべりしない",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_CHECK,settingIdx: 10,
                initValue : widget.os.lpsNewsAlready,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        
        
        self.tblItems.append(
                MsgSettingViewCell(
                title: "話題が尽きたときのふるまい",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        var lpsNewsRunOut : MsgSettingViewCell =
        MsgSettingViewCell(
            title: "",
            content: "",
            partsType: LiplisDefine.PARTS_TYPE_RADIO,settingIdx: 11,
            initValue : widget.os.lpsNewsRunOut,
            trueValue: 0,
            rowHeight: CGFloat(0)
        )
        lpsNewsRunOut.appendChild(
            MsgSettingViewCell(
                title: "ランダムおしゃべり",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 11,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(45)
            )
        )
        lpsNewsRunOut.appendChild(
            MsgSettingViewCell(
                title: "何もしない",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_RADIO_CHILD,
                settingIdx: 11,
                initValue : 0,
                trueValue: 1,
                rowHeight: CGFloat(45)
            )
        )
        self.tblItems.append(lpsNewsRunOut)
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
            let cell : CtvCellWidgetTopicTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellWidgetTopicTitle", forIndexPath: indexPath) as! CtvCellWidgetTopicTitle
            cell.lblTitle.text = cellSetting.title
            return cell
        case 1://チェックボタン
            let cell : CtvCellWidgetTopicCheck = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellWidgetTopicCheck", forIndexPath: indexPath) as! CtvCellWidgetTopicCheck
            cell.setView(self)
            cell.lblTitle.text = cellSetting.title
            cell.lblContent.text = cellSetting.content
            cell.setSize(self.view.frame.width)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)
            return cell
        case 3://ラジオボタン
            let cell : CtvCellWidgetTopicRadio = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellWidgetTopicRadio", forIndexPath: indexPath) as! CtvCellWidgetTopicRadio
            cell.setView(self)
            cell.setRadio(self.view.frame.width, childList: cellSetting.childList)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)
            
            return cell
        default:
            let cell : CtvCellWidgetTopicTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingTitle", forIndexPath: indexPath) as! CtvCellWidgetTopicTitle
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
        widget.os.saveDataFromIdx(settingIdx, val: LiplisUtil.bit2Int(val))
    }
    internal func selectVal(settingIdx : Int, val : Int)
    {
        println("ラジオ選択 idx:" + String(settingIdx) + " val:" + String(val))
        widget.os.saveDataFromIdx(settingIdx, val: val)
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onOrientationChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    internal func onOrientationChange(notification: NSNotification){
        self.setSize()
    }
}
