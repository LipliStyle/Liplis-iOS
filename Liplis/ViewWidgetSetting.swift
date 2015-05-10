//
//  ViewWidgetSetting.swift
//  Liplis
//
//  Created by kosuke on 2015/04/26.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit

class ViewWidgetSetting :  UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // Tabelで使用する配列.
    var tblItems : Array<MsgSettingViewCell>! = []

    ///=============================
    ///ウィジェットインスタンス
    var widget : LiplisWidget!
    
    ///=============================
    ///ビュータイトル
    var viewTitle = "Liplis ウィジェット設定"
    
    ///=============================
    ///画面要素
    var lblTitle : UILabel!
    var btnBack : UIButton!
    //var btnSave : UIButton!
    var tblSetting: UITableView!
    
    ///=============================
    ///オフセット定数
    let labelHight : CGFloat = 60.0
    let headerHight : CGFloat = 25.0
    
    ///=============================
    ///UI定数
    let PARTS_TYPE_TITLE = 0
    let PARTS_TYPE_CHECK = 1
    let PARTS_TYPE_SWITCH = 2
    let PARTS_TYPE_RADIO = 3
    let PARTS_TYPE_RADIO_CHILD = 4
    
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    /*
    コンストラクター
    */
    init(widget : LiplisWidget) {
        super.init()
        self.widget = widget
        tblSetting = UITableView()
        
        //initClass()
        initView()
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
    func initView()
    {
        self.view.opaque = true
        self.view.backgroundColor = UIColor(red:255,green:255,blue:255,alpha:255)
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // Labelを作成.
        lblTitle = UILabel(frame: CGRectMake(0,0,displayWidth,labelHight))
        lblTitle.backgroundColor = UIColor.hexStr("ffa500", alpha: 255)
        lblTitle.text = viewTitle
        lblTitle.textColor = UIColor.whiteColor()
        lblTitle.shadowColor = UIColor.grayColor()
        lblTitle.textAlignment = NSTextAlignment.Center
        lblTitle.layer.position = CGPoint(x: self.view.bounds.width/2,y: headerHight)
        self.view.addSubview(lblTitle)
        
        
        // TableViewの生成( status barの高さ分ずらして表示 ).
        tblSetting.frame = CGRect(x: 0, y: self.lblTitle.frame.height, width: displayWidth, height: displayHeight - self.lblTitle.frame.height)
        tblSetting.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tblSetting.dataSource = self
        tblSetting.delegate = self
        tblSetting.allowsSelection = false
        tblSetting.rowHeight = 20
        //tblSetting.rowHeight = UITableViewAutomaticDimension
        tblSetting.registerClass(CtvCellSettingTitle.self, forCellReuseIdentifier: "CtvCellSettingTitle")
        tblSetting.registerClass(CtvCellSettingSwitch.self, forCellReuseIdentifier: "CtvCellSettingSwitch")
        tblSetting.registerClass(CtvCellSettingCheck.self, forCellReuseIdentifier: "CtvCellSettingCheck")
        tblSetting.registerClass(CtvCellSettingRadio.self, forCellReuseIdentifier: "CtvCellSettingRadio")
        self.view.addSubview(tblSetting)
        
        //テーブルビューアイテム作成
        tblItems = Array<MsgSettingViewCell>()
        
        tblItems.append(MsgSettingViewCell(title: "おしゃべりモード",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
        var lpsMode : MsgSettingViewCell = MsgSettingViewCell(title: "",content: "",partsType: PARTS_TYPE_RADIO,settingIdx: 3,initValue : widget.os.lpsMode, trueValue: 0, rowHeight: CGFloat(0))
        lpsMode.appendChild(MsgSettingViewCell(title: "おしゃべり",content: "10秒おき",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 3,initValue : 0, trueValue: 0, rowHeight: CGFloat(45)))
        lpsMode.appendChild(MsgSettingViewCell(title: "ふつう",content: "30秒おき",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 3,initValue : 0, trueValue: 1, rowHeight: CGFloat(45)))
        lpsMode.appendChild(MsgSettingViewCell(title: "ひかえめ",content: "1分おき",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 3,initValue : 0, trueValue: 2, rowHeight: CGFloat(45)))
        lpsMode.appendChild(MsgSettingViewCell(title: "無口",content: "自動発言なし",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 3,initValue : 0, trueValue: 3, rowHeight: CGFloat(45)))
        tblItems.append(lpsMode)
        
        
        
        tblItems.append(MsgSettingViewCell(title: "アクティブ度",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
        var lpsActive : MsgSettingViewCell = MsgSettingViewCell(title: "",content: "",partsType: PARTS_TYPE_RADIO,settingIdx: 5,initValue : widget.os.lpsSpeed, trueValue: 0, rowHeight: CGFloat(0))
        lpsActive.appendChild(MsgSettingViewCell(title: "おてんば",content: "3倍速 よく動く",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 5,initValue : 0, trueValue: 0, rowHeight: CGFloat(45)))
        lpsActive.appendChild(MsgSettingViewCell(title: "ふつう",content: "2倍速 ふつう",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 5,initValue : 0, trueValue: 1, rowHeight: CGFloat(45)))
        lpsActive.appendChild(MsgSettingViewCell(title: "ゆっくり",content: "1倍速 ひかえめ",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 5,initValue : 0, trueValue: 2, rowHeight: CGFloat(45)))
        tblItems.append(lpsActive)
        
        
        
        tblItems.append(MsgSettingViewCell(title: "アイコンの表示",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
        tblItems.append(MsgSettingViewCell(title: "常にアイコンを表示する",content: "",partsType: PARTS_TYPE_CHECK,settingIdx: 7, initValue : widget.os.lpsDisplayIcon,trueValue: 1, rowHeight: CGFloat(45)))
        
        
        
        tblItems.append(MsgSettingViewCell(title: "バッテリー残量シンクロ",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
        tblItems.append(MsgSettingViewCell(title: "バッテリー残量に応じて状態変化させる",content: "",partsType: PARTS_TYPE_CHECK,settingIdx: 8,initValue : widget.os.lpsHealth,trueValue: 1, rowHeight: CGFloat(45)))
        
        
        
        tblItems.append(MsgSettingViewCell(title: "ウインドウカラー",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
        var lpsWindow : MsgSettingViewCell = MsgSettingViewCell(title: "",content: "",partsType: PARTS_TYPE_RADIO,settingIdx: 6,initValue : widget.os.lpsWindow, trueValue: 0, rowHeight: CGFloat(0))
        lpsWindow.appendChild(MsgSettingViewCell(title: "ウインドウカラー1",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 6,initValue : 0, trueValue: 0, rowHeight: CGFloat(45)))
        lpsWindow.appendChild(MsgSettingViewCell(title: "ウインドウカラー2",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 6,initValue : 0, trueValue: 1, rowHeight: CGFloat(45)))
        lpsWindow.appendChild(MsgSettingViewCell(title: "ウインドウカラー3",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 6,initValue : 0, trueValue: 2, rowHeight: CGFloat(45)))
        lpsWindow.appendChild(MsgSettingViewCell(title: "ウインドウカラー4",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 6,initValue : 0, trueValue: 3, rowHeight: CGFloat(45)))
        lpsWindow.appendChild(MsgSettingViewCell(title: "ウインドウカラー5",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 6,initValue : 0, trueValue: 4, rowHeight: CGFloat(45)))
        lpsWindow.appendChild(MsgSettingViewCell(title: "ウインドウカラー6",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 6,initValue : 0, trueValue: 5, rowHeight: CGFloat(45)))
        lpsWindow.appendChild(MsgSettingViewCell(title: "ウインドウカラー7",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 6,initValue : 0, trueValue: 6, rowHeight: CGFloat(45)))
        tblItems.append(lpsWindow)
        
        
        
//        tblItems.append(MsgSettingViewCell(title: "おしゃべりジャンル",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
//        tblItems.append(MsgSettingViewCell(title: "ニュース",content: "",partsType: PARTS_TYPE_CHECK,settingIdx: 12,initValue : widget.os.lpsTopicNews,trueValue: 1, rowHeight: CGFloat(45)))
//        tblItems.append(MsgSettingViewCell(title: "2ch",content: "",partsType: PARTS_TYPE_CHECK,settingIdx: 13,initValue : widget.os.lpsTopic2ch,trueValue: 1, rowHeight: CGFloat(45)))
//        tblItems.append(MsgSettingViewCell(title: "ニコニコ",content: "",partsType: PARTS_TYPE_CHECK,settingIdx: 14,initValue : widget.os.lpsTopicNico,trueValue: 1, rowHeight: CGFloat(45)))
//        tblItems.append(MsgSettingViewCell(title: "RSS",content: "",partsType: PARTS_TYPE_CHECK,settingIdx: 15,initValue : widget.os.lpsTopicRss,trueValue: 1, rowHeight: CGFloat(45)))
//         tblItems.append(MsgSettingViewCell(title: "Twitter マイタイムライン",content: "",partsType: PARTS_TYPE_CHECK,settingIdx: 18,initValue : widget.os.lpsTopicTwitterMy,trueValue: 1, rowHeight: CGFloat(45)))
//        tblItems.append(MsgSettingViewCell(title: "Twitter パブリックタイムライン",content: "",partsType: PARTS_TYPE_CHECK,settingIdx: 17,initValue : widget.os.lpsTopicTwitterPu,trueValue: 1, rowHeight: CGFloat(45)))
//        tblItems.append(MsgSettingViewCell(title: "Twitter 設定ユーザーツイート",content: "",partsType: PARTS_TYPE_CHECK,settingIdx: 16,initValue : widget.os.lpsTopicTwitter,trueValue: 1, rowHeight: CGFloat(45)))
//        
        
        
//        tblItems.append(MsgSettingViewCell(title: "既読の話題設定",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
//        tblItems.append(MsgSettingViewCell(title: "既読の話題はおしゃべりしない",content: "",partsType: PARTS_TYPE_CHECK,settingIdx: 10,initValue : widget.os.lpsNewsAlready,trueValue: 1, rowHeight: CGFloat(45)))
//        
//        
//        tblItems.append(MsgSettingViewCell(title: "話題が尽きたときのふるまい",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
//        var lpsNewsRunOut : MsgSettingViewCell = MsgSettingViewCell(title: "",content: "",partsType: PARTS_TYPE_RADIO,settingIdx: 11,initValue : widget.os.lpsNewsRunOut, trueValue: 0, rowHeight: CGFloat(0))
//        lpsNewsRunOut.appendChild(MsgSettingViewCell(title: "ランダムおしゃべり",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 11,initValue : 0, trueValue: 0, rowHeight: CGFloat(45)))
//        lpsNewsRunOut.appendChild(MsgSettingViewCell(title: "何もしない",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 11,initValue : 0, trueValue: 1, rowHeight: CGFloat(45)))
//        tblItems.append(lpsNewsRunOut)
//        
//        
//        
//        tblItems.append(MsgSettingViewCell(title: "話題の取得範囲",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
//        var lpsNewsRange : MsgSettingViewCell = MsgSettingViewCell(title: "",content: "",partsType: PARTS_TYPE_RADIO,settingIdx: 9,initValue : widget.os.lpsNewsRange, trueValue: 0, rowHeight: CGFloat(0))
//        lpsNewsRange.appendChild(MsgSettingViewCell(title: "1時間",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 9,initValue : 0, trueValue: 0, rowHeight: CGFloat(45)))
//        lpsNewsRange.appendChild(MsgSettingViewCell(title: "3時間",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 9,initValue : 0, trueValue: 1, rowHeight: CGFloat(45)))
//        lpsNewsRange.appendChild(MsgSettingViewCell(title: "6時間",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 9,initValue : 0, trueValue: 0, rowHeight: CGFloat(45)))
//        lpsNewsRange.appendChild(MsgSettingViewCell(title: "12時間",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 9,initValue : 0, trueValue: 1, rowHeight: CGFloat(45)))
//        lpsNewsRange.appendChild(MsgSettingViewCell(title: "1日",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 9,initValue : 0, trueValue: 0, rowHeight: CGFloat(45)))
//        lpsNewsRange.appendChild(MsgSettingViewCell(title: "3日",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 9,initValue : 0, trueValue: 1, rowHeight: CGFloat(45)))
//        lpsNewsRange.appendChild(MsgSettingViewCell(title: "7日",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 9,initValue : 0, trueValue: 0, rowHeight: CGFloat(45)))
//        lpsNewsRange.appendChild(MsgSettingViewCell(title: "無制限",content: "",partsType: PARTS_TYPE_RADIO_CHILD,settingIdx: 9,initValue : 0, trueValue: 1, rowHeight: CGFloat(45)))
//        tblItems.append(lpsNewsRange)


        //戻るボタン
        btnBack = UIButton()
        btnBack.titleLabel?.font = UIFont.systemFontOfSize(12)
        btnBack.frame = CGRectMake(0,0,displayWidth/6,30)
        btnBack.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        btnBack.layer.masksToBounds = true
        btnBack.setTitle("閉じる", forState: UIControlState.Normal)
        btnBack.addTarget(self, action: "closeMe:", forControlEvents: .TouchDown)
        btnBack.layer.cornerRadius = 3.0
        self.btnBack.frame = CGRect(x: self.lblTitle.frame.origin.x + 5, y: self.lblTitle.frame.origin.y + 25, width: btnBack.frame.width, height: btnBack.frame.height)
        
        //保存ボタン
//        btnSave = UIButton()
//        btnSave.titleLabel?.font = UIFont.systemFontOfSize(12)
//        btnSave.frame = CGRectMake(0,0,displayWidth/6,30)
//        btnSave.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
//        btnSave.layer.masksToBounds = true
//        btnSave.setTitle("保存", forState: UIControlState.Normal)
//        btnSave.addTarget(self, action: "saveSetting:", forControlEvents: .TouchDown)
//        btnSave.layer.cornerRadius = 3.0
        

        self.view.addSubview(btnBack)
        //self.view.addSubview(btnSave)
        
        setSize()
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
        setSize()
    }
    
    
    /*
    画面を閉じる
    */
    func closeMe(sender: AnyObject) {
        widget.setWindow()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)->NSIndexPath? {
        println("Num: \(indexPath.row)")
        println("Value: \(tblItems[indexPath.row].title)")
        
        return nil;
    }
    
    /*
    Cellの総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("numberOfRowsInSection")
        return tblItems.count
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
        return settingCell(indexPath)
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
            let cell : CtvCellSettingTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingTitle", forIndexPath: indexPath) as CtvCellSettingTitle
            cell.lblTitle.text = cellSetting.title
            return cell
        case 1://チェックボタン
            let cell : CtvCellSettingCheck = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingCheck", forIndexPath: indexPath) as CtvCellSettingCheck
            cell.setView(self)
            cell.lblTitle.text = cellSetting.title
            cell.lblContent.text = cellSetting.content
            cell.setSize(self.view.frame.width)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)
            return cell
        case 2://スイッチ
            let cell : CtvCellSettingSwitch = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingSwitch", forIndexPath: indexPath) as CtvCellSettingSwitch
            cell.setView(self)
            cell.lblTitle.text = cellSetting.title
            cell.lblContent.text = cellSetting.content
            cell.setSize(self.view.frame.width)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)
            return cell
        case 3://ラジオボタン
            let cell : CtvCellSettingRadio = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingRadio", forIndexPath: indexPath) as CtvCellSettingRadio
            cell.setView(self)
            cell.setRadio(self.view.frame.width, childList: cellSetting.childList)
            cell.setVal(cellSetting.settingIdx,val: cellSetting.initValue)

            return cell
        default:
            let cell = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellSettingCheck", forIndexPath: indexPath) as CtvCellSettingCheck
            cell.lblTitle.text = cellSetting.title
            cell.lblContent.text = cellSetting.content
            cell.setVal(1,val: 1)
            cell.setSize(self.view.frame.width)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        println("estimatedHeightForRowAtIndexPath" + String(indexPath.row))
        return CGFloat(30)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        println("estimatedHeightForRowAtIndexPath" + String(indexPath.row))
        var cellSetting : MsgSettingViewCell = tblItems[indexPath.row]
        
        return cellSetting.rowHeight
    }
    
    /*
    チェックとスイッチの操作
    */
    func selectCheck(settingIdx : Int, val : Bool)
    {
        println("チェック選択 idx:" + String(settingIdx) + " val:" + String(LiplisUtil.bit2Int(val)))
        widget.os.saveDataFromIdx(settingIdx, val: LiplisUtil.bit2Int(val))
    }
    func selectVal(settingIdx : Int, val : Int)
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
    func setSize()
    {
        var baseHeight : CGFloat = 0
        
        // 現在のデバイスの向きを取得.
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.currentDevice().orientation
        
        // 向きの判定.
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            
            //横向きの判定.
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
            self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: labelHight)
            self.btnBack.frame = CGRect(x: self.lblTitle.frame.origin.x + 5, y: self.lblTitle.frame.origin.y + 25, width: btnBack.frame.width, height: btnBack.frame.height)
            self.tblSetting.frame = CGRect(x: 0, y: self.lblTitle.frame.height, width: displayWidth, height: displayHeight - self.lblTitle.frame.height)

            
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            
            //縦向きの判定.
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
            self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: labelHight)
            self.btnBack.frame = CGRect(x: self.lblTitle.frame.origin.x + 5, y: self.lblTitle.frame.origin.y + 25, width: btnBack.frame.width, height: btnBack.frame.height)
            self.tblSetting.frame = CGRect(x: 0, y: self.lblTitle.frame.height, width: displayWidth, height: displayHeight - self.lblTitle.frame.height)
        }
        
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
    func onOrientationChange(notification: NSNotification){
        setSize()
    }
    
}
