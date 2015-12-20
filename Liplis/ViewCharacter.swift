//
//  ViewCharacter.swift
//  Liplis
//
//  キャラクター選択画面
//
//アップデート履歴
//   2015/04/20 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/14 ver1.3.0　キャラクター画面切り替え時、再ロードするように修正
//                        タグの文字を変更
//                        画面回転時の処理変更
//   2015/05/16 ver1.4.0　swift1.2対応
//
//
//  Created by sachin on 2015/04/20.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class ViewCharacter : UIViewController, UITableViewDelegate, UITableViewDataSource {
    ///=============================
    ///アプリケーションデリゲート
    private var app : AppDelegate!
    
    ///=============================
    ///ビュータイトル
    private var viewTitle = "Liplisキャラクター"
    private var tagTitle = "キャラクター"
    
    ///=============================
    ///画面要素
    private var lblTitle : UILabel!
    private var tblCharList: UITableView!
    
    ///=============================
    ///オフセット定数
    private let labelHight : CGFloat = 60.0
    private let headerHight : CGFloat = 25.0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /*
    コンストラクター
    */
    internal convenience init(app : AppDelegate) {
        self.init(nibName: nil, bundle: nil)
        self.app = app
        self.initClass()
        self.initView()
    }
    required init?(coder aDecoder: NSCoder) {
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
        let img : UIImage = UIImage(named : ObjR.imgIconChar)!                   //アイコン取得
        self.view.opaque = true                                                     //背景透過許可
        self.view.backgroundColor = UIColor(red:255,green:255,blue:255,alpha:255)   //白透明背景
        self.tabBarItem = UITabBarItem(title: self.tagTitle,image: img, tag: 3)     //タブ設定
        
        //タイトルラベルの作成
        self.createLblTitle()
        
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
        // Labelを作成.
        self.lblTitle = UILabel(frame: CGRectMake(0,0,0,0))
        self.lblTitle.backgroundColor = UIColor.hexStr("ffa500", alpha: 255)
        self.lblTitle.text = self.viewTitle
        self.lblTitle.textColor = UIColor.whiteColor()
        self.lblTitle.shadowColor = UIColor.grayColor()
        self.lblTitle.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.lblTitle)
    }
    
    /*
    キャラクター要素テーブルの初期化
    */
    private func createTableView()
    {
        self.tblCharList = UITableView(frame: CGRectMake(0,0,0,0))
        self.tblCharList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CharCell")
        self.tblCharList.dataSource = self
        self.tblCharList.delegate = self
        self.view.addSubview(tblCharList)
    }
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    /*
    ロードイベント
    */
    internal override func viewDidLoad() {
        super.viewDidLoad()
    }

    /*
    ビュー呼び出し時
    */
    internal override func viewWillAppear(animated: Bool) {
        //リスト再読み込み
        self.app.cman.skinDataListReload()
        self.tblCharList.reloadData()
        
        //サイズ設定
        self.setSize()
    }
    
    /*
    メモリーワーニング
    */
    internal override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    Cellが選択された際に呼び出されるデリゲートメソッド.
    */
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(self.app.cman.skinDataList[indexPath.row].charName)")
        
        //デスクトップに移動し、洗濯したウィジェットを追加する
        self.tabBarController?.selectedIndex=0
        self.app.activityDeskTop.addNewWidget(self.app.cman.skinDataList[indexPath.row])
    }
    
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.app.cman.skinDataList.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell! = UITableViewCell(style: UITableViewCellStyle.Subtitle,reuseIdentifier:"CharCell")
        cell.textLabel!.text = self.app.cman.skinDataList[indexPath.row].charName
        cell.detailTextLabel!.text = self.app.cman.skinDataList[indexPath.row].charDescription
        cell.imageView!.image = self.app.cman.skinDataList[indexPath.row].imgIco
        return cell;
    }
    
    /*
    テーブルビュー高さ設定
    */
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
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
            //横向きの判定.
   
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            //縦向きの判定.
        }
        
        //サイズ設定
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        //let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        self.lblTitle.frame = CGRectMake(0, 0, displayWidth, self.labelHight)
        self.tblCharList.frame = CGRectMake(0, self.lblTitle.frame.height, displayWidth, displayHeight - self.lblTitle.frame.height - LiplisDefine.futterHight)
        
        //テーブルのリロード
        self.tblCharList.reloadData()
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
        self.setSize()
    }
}