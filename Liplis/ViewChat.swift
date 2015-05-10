//
//  ViewChat.swift
//  Liplis
//
//  Created by kosuke on 2015/04/26.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit

class ViewChat : UIViewController,UITextFieldDelegate{
    
    ///=============================
    ///対象リプリスインスタンス
    var widget : LiplisWidget!
    
    ///=============================
    ///ビュータイトル
    //var viewTitle = "話しかける"
    
    ///=============================
    ///画面要素
    //var lblTitle : UILabel!
    //var backBtn: UIButton!
    var txtChat: UITextField!
    var btnSend: UIButton!
    //=================================
    //リプリスベース設定
    var baseSetting : LiplisPreference!
    
    
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
    init(widget : LiplisWidget) {
        super.init()
        
        //ウィジェットインスタンスの取得
        self.widget = widget
        
        initClass()
        initView()
        
        setSize()
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
        self.view.opaque = false
        self.view.backgroundColor = UIColor(white: 0.2,alpha: 0.2)
        var img : UIImage = UIImage(named : "sel_setting.png")!
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
//        // Labelを作成.
//        lblTitle = UILabel(frame: CGRectMake(0,0,displayWidth,labelHight))
//        lblTitle.backgroundColor = UIColor.hexStr("ffa500", alpha: 255)
//        lblTitle.text = viewTitle
//        lblTitle.textColor = UIColor.whiteColor()
//        lblTitle.shadowColor = UIColor.grayColor()
//        lblTitle.textAlignment = NSTextAlignment.Center
//        lblTitle.layer.position = CGPoint(x: self.view.bounds.width/2,y: headerHight)
//        self.view.addSubview(lblTitle)
//
//        //閉じるボタン生成
//        backBtn = UIButton()
//        backBtn.frame = CGRectMake(0,0,100,35)
//        backBtn.backgroundColor = UIColor.hexStr("DF7401", alpha: 255)
//        backBtn.layer.masksToBounds = true
//        backBtn.setTitle("閉じる", forState: UIControlState.Normal)
//        backBtn.addTarget(self, action: "closeMe:", forControlEvents: .TouchDown)
//        backBtn.layer.cornerRadius = 3.0
//        
//        self.view.addSubview(backBtn)
        
        // UITextFieldを作成する.
        txtChat = UITextField(frame: CGRectMake(0,0,200,30))
        txtChat.borderStyle = UITextBorderStyle.RoundedRect
        txtChat.text = ""
        txtChat.delegate = self
        txtChat.becomeFirstResponder()
        
        //閉じるボタン生成
        btnSend = UIButton()
        btnSend.frame = CGRectMake(0,0,30,30)
        btnSend.layer.masksToBounds = true
        btnSend.setTitle("送信", forState: UIControlState.Normal)
        btnSend.addTarget(self, action: "onClickBtnSend:", forControlEvents: .TouchDown)
        btnSend.layer.cornerRadius = 3.0
        btnSend.backgroundColor = UIColor.hexStr("A5A5A5", alpha: 255)
        
        // Viewに追加する.
        self.view.addSubview(txtChat)
        self.view.addSubview(btnSend)
        
        //キーボードイベントハンドラ
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
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
        //サイズ設定
        txtChat.becomeFirstResponder()
        setSize()
    }
    
    /*
    メモリーワーニング
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    エンター入力
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendChat()
        //closeMe()
        return false
    }
    
    /*
    送信ボタン押下
    */
    func onClickBtnSend(sender: AnyObject)
    {
        sendChat()
    }
    
    /*
    画面タッチ（閉じる）
    */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        closeMe()
    }
    
    /*
    画面を閉じる
    */
    func closeMe()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    キーボード表示
    */
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.btnSend.frame = CGRect(x: 0, y: self.view.frame.height - keyboardSize.height - 67, width: 50, height: 30)
            self.txtChat.frame = CGRect(x: self.btnSend.frame.width, y: self.view.frame.height - keyboardSize.height - 67, width: self.view.frame.width -  self.btnSend.frame.width, height: 30)
        }
    }
    
    /*
    キーボード閉じ時
    */
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.btnSend.frame = CGRect(x: 0, y: self.view.frame.height - 35, width: 50, height: 30)
            self.txtChat.frame = CGRect(x: self.btnSend.frame.width, y: self.view.frame.height - 35, width: self.view.frame.width - self.btnSend.frame.width, height: 30)
        }
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
//            self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: labelHight)
//            self.backBtn.frame = CGRect(x: self.lblTitle.frame.origin.x + 10, y: self.lblTitle.frame.origin.y + 20, width: backBtn.frame.width, height: backBtn.frame.height)

        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            
            //縦向きの判定.
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
//            self.lblTitle.frame = CGRect(x: 0, y: 0, width: displayWidth, height: labelHight)
//            self.backBtn.frame = CGRect(x: self.lblTitle.frame.origin.x + 10, y: self.lblTitle.frame.origin.y + 20, width: backBtn.frame.width, height: backBtn.frame.height)
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
    
    //============================================================
    //
    //おしゃべり処理
    //
    //============================================================
    /*
    チャットテキストを送信する
    */
    func sendChat()
    {
        widget.chatTalkRecive(txtChat.text)
        txtChat.text = ""
    }
    
    
}