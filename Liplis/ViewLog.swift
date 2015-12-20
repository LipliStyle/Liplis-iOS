//
//  ViewLog.swift
//  Liplis
//
//  Liplisログ画面
//
//アップデート履歴
//   2015/04/20 ver0.1.0 作成
//   2015/05/13 ver1.2.0 ログの送りバグ修正
//   2015/05/16 ver1.4.0　swift1.2対応
//                        リファクタリング
//
//  Created by sachin on 2015/04/20.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class ViewLog : UIViewController, UITableViewDelegate, UITableViewDataSource {
    ///=============================
    ///アプリケーションデリゲート
    private var app : AppDelegate!
    
    ///=============================
    ///ビュータイトル
    private var viewTitle = "Liplisログ"
    private var tagTitle = "ログ"
    
    ///=============================
    ///画面要素
    private var lblTitle : UILabel!
    private var tblLog: UITableView!
    
    ///=============================
    ///画面要素
    internal var logList : Array<ObjLiplisLog>!
    
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
        self.logList = []
    }
    
    /*
    アクティビティの初期化
    */
    private func initView()
    {
        //ビューの初期化
        let img : UIImage = UIImage(named : ObjR.imgIconIntoro)!                   //アイコン取得
        self.view.opaque = true                                                     //背景透過許可
        self.view.backgroundColor = UIColor(red:255,green:255,blue:255,alpha:255)   //白透明背景
        self.tabBarItem = UITabBarItem(title: self.tagTitle,image: img, tag: 4)     //タブ設定
        
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
        self.tblLog = UITableView(frame: CGRectMake(0,0,0,0))
        self.tblLog.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.tblLog.dataSource = self
        self.tblLog.delegate = self
        self.view.addSubview(tblLog)
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
        //ログリスト
        self.logList = self.app.activityDeskTop.lpsLog.logList
        self.tblLog.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        //サイズ設定
        self.setSize()
        self.tblLog.reloadData()
        self.moveLowerMostPart()
    }
    
    /*
    メモリーワーニング
    */
    internal override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(self.logList[indexPath.row].url != "")
        {
            print("Num: \(indexPath.row)")
            print("Value: \(self.logList[indexPath.row].log)")
            print("Value: \(self.logList[indexPath.row].url)")
            
            //ベース設定の取得
            let baseSetting : LiplisPreference = LiplisPreference.SharedInstance
            
            
            //ブラウザモードチェック
            if baseSetting.lpsBrowserMode == 0
            {
                //ブラウザモードが0なら、アプリ内ブラウザで表示する
                self.app.activityWeb.url = NSURL(string: self.logList[indexPath.row].url)!
                self.tabBarController?.selectedIndex=4
            }
            else  if baseSetting.lpsBrowserMode == 1
            {
                //ブラウザモードが1ならサファリで表示する
                let nurl = NSURL(string: self.logList[indexPath.row].url)
                if UIApplication.sharedApplication().canOpenURL(nurl!){
                    UIApplication.sharedApplication().openURL(nurl!)
                }
            }
            else  if baseSetting.lpsBrowserMode == 2
            {
                //ブラウザモードが2ならデスクトップ背景に表示する(未実装)
                self.app.activityDeskTop.desktopWebSetUrl(self.logList[indexPath.row].url)
                self.tabBarController?.selectedIndex=0
            }
        }
    }
    
    /*
    Cellの総数を返す.
    */
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logList.count
    }
    
    /*
    Cellに値を設定する.
    */
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Cellの.を取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) 
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(self.logList[indexPath.row].log)"
        
        return cell
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
        //let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: LiplisDefine.labelHight)
        self.tblLog.frame = CGRectMake(0, self.lblTitle.frame.height, displayWidth, displayHeight - self.lblTitle.frame.height - LiplisDefine.futterHight)
    }
    
    /*
    最下部にスクロールする
    */
    internal func moveLowerMostPart()
    {
        self.tblLog.setContentOffset(CGPointMake(0, self.tblLog.contentSize.height - self.tblLog.frame.size.height), animated: false)
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