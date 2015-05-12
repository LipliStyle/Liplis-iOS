//
//  ViewCharacter.swift
//  Liplis
//
//  Created by sachin on 2015/04/20.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class ViewCharacter : UIViewController, UITableViewDelegate, UITableViewDataSource {
    ///=============================
    ///アプリケーションデリゲート
    var app : AppDelegate!
    
    ///=============================
    ///ビュータイトル
    var viewTitle = "Liplisキャラクター"
    var tagTitle = "キャラクター"
    
    ///=============================
    ///画面要素
    var lblTitle : UILabel!
    var tblCharList: UITableView!
    
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
        var img : UIImage = UIImage(named : "sel_char.png")!
        self.tabBarItem = UITabBarItem(title: "Character",image: img, tag: 3)
        
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
        tblCharList = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        tblCharList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CharCell")
        tblCharList.dataSource = self
        tblCharList.delegate = self
        self.view.addSubview(tblCharList)
        
        setSize()
    }
    
    func loadCharList()
    {
        let width = self.view.frame.maxX, height = self.view.frame.maxY
        
        
        // 表示する画像を設定する.
        let myImage = UIImage(named: "normal_1_1_1")
        var myImageView: UIImageView! = UIImageView(frame: CGRectMake(0,0,240,300))
        myImageView.image = myImage
        myImageView.frame = CGRectMake(CGFloat(0) * width + width/2 - myImageView.frame.width/2, height/2 - myImageView.frame.height/2, myImageView.frame.width, myImageView.frame.height)
        myImageView.userInteractionEnabled = true
        
        // 表示する画像を設定する.
        let myImage2 = UIImage(named: "normal_4_1_1")
        var myImageView2 : UIImageView! = UIImageView(frame: CGRectMake(0,0,240,300))
        myImageView2.image = myImage2
        myImageView2.frame = CGRectMake(CGFloat(1) * width + width/2 - myImageView2.frame.width/2, height/2 - myImageView2.frame.height/2, myImageView2.frame.width, myImageView2.frame.height)
        myImageView2.userInteractionEnabled = true
        

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
        //リスト再読み込み
        app.cman.skinDataListReload()
        
        //サイズ設定
        setSize()
    }
    
    /*
    メモリーワーニング
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    Cellが選択された際に呼び出されるデリゲートメソッド.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Num: \(indexPath.row)")
        println("Value: \(app.cman.skinDataList[indexPath.row].charName)")
        
        self.tabBarController?.selectedIndex=0
        self.app.activityDeskTop.addNewWidget(app.cman.skinDataList[indexPath.row])
    }
    
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app.cman.skinDataList.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = UITableViewCell(style: UITableViewCellStyle.Subtitle,reuseIdentifier:"CharCell")
        cell.textLabel!.text = app.cman.skinDataList[indexPath.row].charName
        cell.detailTextLabel!.text = app.cman.skinDataList[indexPath.row].charDescription
        cell.imageView!.image = app.cman.skinDataList[indexPath.row].imgIco
        return cell;
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
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
    func setSize()
    {
        // 現在のデバイスの向きを取得.
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.currentDevice().orientation
        var idx : Int = 0
        
        // 向きの判定.
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            
            //横向きの判定.
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
            self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: labelHight)
            
            // スクロールの画面サイズを指定する.
            let width = self.view.frame.maxX
            let height = self.view.frame.maxY

            
            self.tblCharList.frame = CGRect(x: 0, y: self.lblTitle.frame.height, width: displayWidth, height: displayHeight - self.lblTitle.frame.height)
   
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            
            //縦向きの判定.
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
            self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: labelHight)
            
            // スクロールの画面サイズを指定する.
            let width = self.view.frame.maxX
            let height = self.view.frame.maxY

            self.tblCharList.frame = CGRect(x: 0, y: self.lblTitle.frame.height, width: displayWidth, height: displayHeight - self.lblTitle.frame.height)
            
            
        }
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