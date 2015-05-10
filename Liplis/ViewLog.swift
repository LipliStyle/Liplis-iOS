//
//  ViewLog.swift
//  Liplis
//
//  Created by kosuke on 2015/04/20.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class ViewLog : UIViewController, UITableViewDelegate, UITableViewDataSource {
    ///=============================
    ///アプリケーションデリゲート
    var app : AppDelegate!
    
    ///=============================
    ///ビュータイトル
    var viewTitle = "Liplisログ"
    var tagTitle = "ログ"
    
    ///=============================
    ///画面要素
    var lblTitle : UILabel!
    var tblLog: UITableView!
    
    ///=============================
    ///オフセット定数
    let labelHight : CGFloat = 60.0
    let headerHight : CGFloat = 25.0
    
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
        
    }
    
    /*
    アクティビティの初期化
    */
    func initView()
    {
        self.view.opaque = true
        self.view.backgroundColor = UIColor(red:255,green:255,blue:255,alpha:255)
        var img : UIImage = UIImage(named : "sel_intro.png")!
        self.tabBarItem = UITabBarItem(title: tagTitle,image: img, tag: 4)
        
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
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
    
        // TableViewの生成する(status barの高さ分ずらして表示).
        tblLog  = UITableView(frame: CGRect(x: 0, y: barHeight+headerHight, width: displayWidth, height: displayHeight - barHeight - 83))
        tblLog.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tblLog.dataSource = self
        tblLog.delegate = self
        self.view.addSubview(tblLog)
        
        //サイズ設定
        setSize()
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
    
    /*
    ビュー呼び出し時
    */
    override func viewWillAppear(animated: Bool) {
        //ログリスト
        self.tblLog.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        //サイズ設定
        self.setSize()
        self.tblLog.reloadData()
        self.moveLowerMostPart()
    }
    
    /*
    メモリーワーニング
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(self.app.activityDeskTop.lpsLog.logList[indexPath.row].url != "")
        {
            println("Num: \(indexPath.row)")
            println("Value: \(self.app.activityDeskTop.lpsLog.logList[indexPath.row].log)")
            println("Value: \(self.app.activityDeskTop.lpsLog.logList[indexPath.row].url)")
            
            //ベース設定の取得
            var baseSetting : LiplisPreference = LiplisPreference.SharedInstance
            
            if baseSetting.lpsBrowserMode == 0
            {
                self.app.activityWeb.url = NSURL(string: self.app.activityDeskTop.lpsLog.logList[indexPath.row].url)!
                self.tabBarController?.selectedIndex=4
            }
            else  if baseSetting.lpsBrowserMode == 1
            {
                let nurl = NSURL(string: self.app.activityDeskTop.lpsLog.logList[indexPath.row].url)
                if UIApplication.sharedApplication().canOpenURL(nurl!){
                    UIApplication.sharedApplication().openURL(nurl!)
                }
            }
            else  if baseSetting.lpsBrowserMode == 2
            {
                //URL設定
                self.app.activityDeskTop.desktopWebSetUrl(self.app.activityDeskTop.lpsLog.logList[indexPath.row].url)
                self.tabBarController?.selectedIndex=0
            }
        }
    }
    
    /*
    Cellの総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.app.activityDeskTop.lpsLog.logList.count
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Cellの.を取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(self.app.activityDeskTop.lpsLog.logList[indexPath.row].log)"
        
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
    func setSize()
    {
        // 現在のデバイスの向きを取得.
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.currentDevice().orientation
        
        // 向きの判定.
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            
            //横向きの判定.
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
            self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: labelHight)
            self.tblLog.frame = CGRect(x: 0, y: barHeight + headerHight * 2, width: displayWidth, height: displayHeight - barHeight - 100)
            
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            
            //縦向きの判定.
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
            self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: labelHight)
            self.tblLog.frame = CGRect(x: 0, y: barHeight + headerHight, width: displayWidth, height: displayHeight - barHeight - 75)
        }
    }
    
    /*
    最下部にスクロールする
    */
    func moveLowerMostPart()
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
    override func viewDidAppear(animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onOrientationChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    func onOrientationChange(notification: NSNotification){
        setSize()
    }
}