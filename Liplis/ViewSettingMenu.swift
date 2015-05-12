//
//  ViewSettingSelector.swift
//  Liplis
//
//  Created by sachin on 2015/05/04.
//  Copyright (c) 2015年 sachin. All rights reserved.
//


import UIKit

class ViewSettingMenu :  UIViewController, UITableViewDelegate, UITableViewDataSource{
    ///=============================
    ///アプリケーションデリゲート
    var app : AppDelegate!
    
    // Tabelで使用する配列.
    var tblItems : Array<MsgSettingViewCell>! = []
    
    //=================================
    //リプリスベース設定
    var baseSetting : LiplisPreference!
    
    ///=============================
    ///ビュータイトル
    var viewTitle = "Liplisメニュー"
    
    ///=============================
    ///画面要素
    var lblTitle : UILabel!
    var btnBack : UIButton!
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
    init(app : AppDelegate) {
        super.init()
        self.app = app
        
        tblSetting = UITableView()
        
        initClass()
        initView()
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
    func initClass()
    {
        baseSetting = LiplisPreference.SharedInstance
    }
    
    /*
    アクティビティの初期化
    */
    func initView()
    {
        self.view.opaque = true
        self.view.backgroundColor = UIColor(red:255,green:255,blue:255,alpha:255)
        var img : UIImage = UIImage(named : "sel_setting.png")!
        self.tabBarItem = UITabBarItem(title: "設定",image: img, tag: 2)
        
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
        tblSetting.registerClass(CtvCellMenuTitle.self, forCellReuseIdentifier: "CtvCellMenuTitle")
        tblSetting.registerClass(CtvCellMenuIntoroduction.self, forCellReuseIdentifier: "CtvCellMenuIntoroduction")
        tblSetting.registerClass(CtvCellMenuSetting.self, forCellReuseIdentifier: "CtvCellMenuSetting")
        tblSetting.registerClass(CtvCellMenuSite.self, forCellReuseIdentifier: "CtvCellMenuSite")
        tblSetting.registerClass(CtvCellMenuHelpSite.self, forCellReuseIdentifier: "CtvCellMenuHelpSite")
        tblSetting.registerClass(CtvCellMenuCtrlWidget.self, forCellReuseIdentifier: "CtvCellMenuCtrlWidget")
        self.view.addSubview(tblSetting)
        
        //テーブルビューアイテム作成
        tblItems = Array<MsgSettingViewCell>()
        tblItems.append(MsgSettingViewCell(title: "リプリス設定メニュー",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
        tblItems.append(MsgSettingViewCell(title: "",content: "",partsType: 1,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(100)))
        tblItems.append(MsgSettingViewCell(title: "ウィジェット操作",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
        
        tblItems.append(MsgSettingViewCell(title: "",content: "",partsType: 2,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(70)))
        tblItems.append(MsgSettingViewCell(title: "リプリス設定",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
        
        tblItems.append(MsgSettingViewCell(title: "",content: "",partsType: 3,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(70)))
        tblItems.append(MsgSettingViewCell(title: "Liplisヘルプ",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
        tblItems.append(MsgSettingViewCell(title: "",content: "",partsType: 5,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(70)))
        tblItems.append(MsgSettingViewCell(title: "LipliStyleサイト",content: "",partsType: PARTS_TYPE_TITLE,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(26)))
        tblItems.append(MsgSettingViewCell(title: "",content: "",partsType: 4,settingIdx: -1,initValue : 0, trueValue: 0, rowHeight: CGFloat(70)))

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
        
        
        
        self.view.addSubview(btnBack)
        
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
        self.tabBarController?.selectedIndex=0
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
            let cell : CtvCellMenuTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuTitle", forIndexPath: indexPath) as CtvCellMenuTitle
            cell.lblTitle.text = cellSetting.title
            return cell
        case 1://イントロダクション
            return self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuIntoroduction", forIndexPath: indexPath) as CtvCellMenuIntoroduction
        case 2://設定画面
            let cell : CtvCellMenuCtrlWidget = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuCtrlWidget", forIndexPath: indexPath) as CtvCellMenuCtrlWidget
            cell.setView(self)
            cell.setSize(self.view.frame.width)
            return cell
        case 3://設定画面
            let cell : CtvCellMenuSetting = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuSetting", forIndexPath: indexPath) as CtvCellMenuSetting
            cell.setView(self)
            cell.setSize(self.view.frame.width)
            return cell
        case 4://設定画面
            let cell : CtvCellMenuSite = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuSite", forIndexPath: indexPath) as CtvCellMenuSite
            cell.setView(self)
            cell.setSize(self.view.frame.width)
            return cell
        case 5://設定画面
            let cell : CtvCellMenuHelpSite = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuHelpSite", forIndexPath: indexPath) as CtvCellMenuHelpSite
            cell.setView(self)
            cell.setSize(self.view.frame.width)
            return cell
        default:
            let cell : CtvCellMenuTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuTitle", forIndexPath: indexPath) as CtvCellMenuTitle
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
        var cellSetting : MsgSettingViewCell = tblItems[indexPath.row]
        
        return cellSetting.rowHeight
    }
    
    /*
    ボタン操作
    */
    
    
    
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
