//
//  ViewWeb.swift
//  Liplis
//
//  Liplisアプリ内ブラウザ
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
class ViewWeb : UIViewController , UIWebViewDelegate {
    ///=============================
    ///アプリケーションデリゲート
    private var app : AppDelegate!
    
    ///=============================
    ///ビュータイトル
    private var viewTitle = "ウェブ参照"
    private var tagTitle = "ウェブ"
    
    ///=============================
    ///画面要素
    private var lblTitle : UILabel!
    internal var myWebView : UIWebView!
    
    // URLを設定する.
    internal var url: NSURL = NSURL(string: "")!
    
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
    
    required init(coder aDecoder: NSCoder) {
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
        var img : UIImage = UIImage(named : ObjR.imgIconWeb)!                       //アイコン取得
        self.view.opaque = true                                                     //背景透過許可
        self.view.backgroundColor = UIColor(red:255,green:255,blue:255,alpha:255)   //白透明背景
        self.tabBarItem = UITabBarItem(title: self.tagTitle,image: img, tag: 5)     //タブ設定
        
        //タイトルラベルの作成
        self.createLblTitle()
        
        //テーブル作成
        self.createWebleView()
        
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
    private func createWebleView()
    {
        self.myWebView = UIWebView()
        self.myWebView.delegate = self
        self.myWebView.frame = self.view.bounds
        self.myWebView.scalesPageToFit = true
        self.view.addSubview(myWebView)
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
    internal func webViewDidFinishLoad(webView: UIWebView) {
        println("webViewDidFinishLoad")
    }
    
    /*
    Pageがloadされ始めた時、呼ばれる
    */
    internal func webViewDidStartLoad(webView: UIWebView) {
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
    private func setSize()
    {
        // 現在のデバイスの向きを取得.
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.currentDevice().orientation
        
        // 向きによって設定サイズを調整する
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            //横向きの判定
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            //縦向きの判定
        }
        
        //ビューフレームサイズを取得
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: LiplisDefine.labelHight)
        self.myWebView.frame = CGRectMake(0, self.lblTitle.frame.height, displayWidth, displayHeight - self.lblTitle.frame.height - LiplisDefine.futterHight)
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
        setSize()
    }
}