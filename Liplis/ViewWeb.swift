//
//  ViewWeb.swift
//  Liplis
//
//  Created by sachin on 2015/04/20.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
class ViewWeb : UIViewController , UIWebViewDelegate {
    ///=============================
    ///アプリケーションデリゲート
    var app : AppDelegate!
    
    ///=============================
    ///ビュータイトル
    var viewTitle = "ウェブ参照"
    var tagTitle = "ウェブ"
    
    ///=============================
    ///画面要素
    var lblTitle : UILabel!
    let myWebView : UIWebView = UIWebView()
    
    ///=============================
    ///オフセット定数
    let labelHight : CGFloat = 60.0
    let headerHight : CGFloat = 25.0
    
    // URLを設定する.
    var url: NSURL = NSURL(string: "")!
    
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
        var img : UIImage = UIImage(named : "sel_in.png")!
        self.tabBarItem = UITabBarItem(title: tagTitle,image: img, tag: 5)

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
        
        myWebView.delegate = self
        myWebView.frame = self.view.bounds
        myWebView.scalesPageToFit = true
        self.view.addSubview(myWebView)
        
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
        // リクエストを作成する.
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        // リクエストを実行する.
        myWebView.loadRequest(request)
        
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
    Pageがすべて読み込み終わった時呼ばれる
    */
    func webViewDidFinishLoad(webView: UIWebView) {
        println("webViewDidFinishLoad")
    }
    
    /*
    Pageがloadされ始めた時、呼ばれる
    */
    func webViewDidStartLoad(webView: UIWebView) {
        println("webViewDidStartLoad")
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
        //ビューフレームサイズを取得
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        //バー高さ
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        //ラベル位置設定
        self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: labelHight)
        
        // 現在のデバイスの向きを取得.
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.currentDevice().orientation
        
        // 向きによって設定サイズを調整する
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            //横向きの判定.
            self.myWebView.frame = CGRect(x: 0, y: barHeight + headerHight * 2, width: displayWidth, height: displayHeight - barHeight - 100)
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            //縦向きの判定.
            self.myWebView.frame = CGRect(x: 0, y: barHeight + headerHight, width: displayWidth, height: displayHeight - barHeight - 75)
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