//
//  ViewSettingMenu.swift
//  Liplis
//
//  Liplisの設定メニュー
//
//アップデート履歴
//   2015/05/04 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/14 ver1.3.0　リファクタリング
//   2015/05/16 ver1.4.0　swift1.2対応
//
//  Created by sachin on 2015/05/04.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit

class ViewSettingMenu :  UIViewController, UITableViewDelegate, UITableViewDataSource{
    ///=============================
    ///アプリケーションデリゲート
    internal var app : AppDelegate!
    
    ///=============================
    ///テーブル要素
    private var tblItems : Array<MsgSettingViewCell>! = []
    
    //=================================
    //リプリスベース設定
    private var baseSetting : LiplisPreference!
    
    ///=============================
    ///ビュータイトル
    private var viewTitle = "Liplisメニュー"
    private var tagTitle = "設定"
    
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
    convenience init(app : AppDelegate) {
        self.init(nibName: nil, bundle: nil)
        //アプリケーションデリゲート取得
        self.app = app
        
        //クラスの初期化
        self.initClass()
        
        //ビューの初期化
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
    func initClass()
    {
        self.baseSetting = LiplisPreference.SharedInstance
    }
    
    /*
    画面要素の初期化
    */
    private func initView()
    {
        //ビューの初期化
        var img : UIImage = UIImage(named : ObjR.imgIconSetting)!                   //アイコン取得
        self.view.opaque = true                                                     //背景透過許可
        self.view.backgroundColor = UIColor(red:255,green:255,blue:255,alpha:255)   //白透明背景
        self.tabBarItem = UITabBarItem(title: self.tagTitle,image: img, tag: 2)     //タブ設定
        
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
        btnBack = UIButton()
        btnBack.titleLabel?.font = UIFont.systemFontOfSize(12)
        btnBack.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
        btnBack.layer.masksToBounds = true
        btnBack.setTitle("閉じる", forState: UIControlState.Normal)
        btnBack.addTarget(self, action: "closeMe:", forControlEvents: .TouchDown)
        btnBack.layer.cornerRadius = 3.0
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
        self.tblSetting.registerClass(CtvCellMenuTitle.self, forCellReuseIdentifier: "CtvCellMenuTitle")
        self.tblSetting.registerClass(CtvCellMenuIntoroduction.self, forCellReuseIdentifier: "CtvCellMenuIntoroduction")
        self.tblSetting.registerClass(CtvCellMenuSetting.self, forCellReuseIdentifier: "CtvCellMenuSetting")
        self.tblSetting.registerClass(CtvCellMenuSite.self, forCellReuseIdentifier: "CtvCellMenuSite")
        self.tblSetting.registerClass(CtvCellMenuHelpSite.self, forCellReuseIdentifier: "CtvCellMenuHelpSite")
        self.tblSetting.registerClass(CtvCellMenuCtrlWidget.self, forCellReuseIdentifier: "CtvCellMenuCtrlWidget")
        self.view.addSubview(tblSetting)
        
        //テーブルビューアイテム作成
        tblItems = Array<MsgSettingViewCell>()
        tblItems.append(
            MsgSettingViewCell(
                title: "リプリス設定メニュー",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        tblItems.append(
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
        tblItems.append(
            MsgSettingViewCell(
                title: "ウィジェット操作",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight:
                CGFloat(26)
            )
        )
        tblItems.append(
            MsgSettingViewCell(
                title: "",
                content: "",
                partsType: 2,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(70)
            )
        )
        tblItems.append(
            MsgSettingViewCell(
                title: "リプリス設定",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        tblItems.append(
            MsgSettingViewCell(
                title: "",
                content: "",
                partsType: 3,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(70)
            )
        )
        tblItems.append(
            MsgSettingViewCell(
                title: "Liplisヘルプ",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        tblItems.append(
            MsgSettingViewCell(
                title: "",content: "",
                partsType: 5,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(70)
            )
        )
        tblItems.append(
            MsgSettingViewCell(
                title: "LipliStyleサイト",
                content: "",
                partsType: LiplisDefine.PARTS_TYPE_TITLE,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(26)
            )
        )
        tblItems.append(
            MsgSettingViewCell(
                title: "",
                content: "",
                partsType: 4,
                settingIdx: -1,
                initValue : 0,
                trueValue: 0,
                rowHeight: CGFloat(70)
            )
        )
    }
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    /*
    ロードイベント
    */
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
    internal func closeMe(sender: AnyObject) {
        self.tabBarController?.selectedIndex=0
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
            let cell : CtvCellMenuTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuTitle", forIndexPath: indexPath) as! CtvCellMenuTitle
            cell.lblTitle.text = cellSetting.title
            return cell
        case 1://イントロダクション
            return self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuIntoroduction", forIndexPath: indexPath) as! CtvCellMenuIntoroduction
        case 2://設定画面
            let cell : CtvCellMenuCtrlWidget = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuCtrlWidget", forIndexPath: indexPath) as! CtvCellMenuCtrlWidget
            cell.setView(self)
            cell.setSize(self.view.frame.width)
            return cell
        case 3://設定画面
            let cell : CtvCellMenuSetting = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuSetting", forIndexPath: indexPath) as! CtvCellMenuSetting
            cell.setView(self)
            cell.setSize(self.view.frame.width)
            return cell
        case 4://設定画面
            let cell : CtvCellMenuSite = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuSite", forIndexPath: indexPath) as! CtvCellMenuSite
            cell.setView(self)
            cell.setSize(self.view.frame.width)
            return cell
        case 5://設定画面
            let cell : CtvCellMenuHelpSite = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuHelpSite", forIndexPath: indexPath) as! CtvCellMenuHelpSite
            cell.setView(self)
            cell.setSize(self.view.frame.width)
            return cell
        default:
            let cell : CtvCellMenuTitle = self.tblSetting.dequeueReusableCellWithIdentifier("CtvCellMenuTitle", forIndexPath: indexPath) as! CtvCellMenuTitle
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
        
         //画面要素調整
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
