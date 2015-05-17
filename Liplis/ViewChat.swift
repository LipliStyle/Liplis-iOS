//
//  ViewChat.swift
//  Liplis
//
//  Liplis話しかけ画面
//
//アップデート履歴
//   2015/04/26 ver0.1.0 作成
//   2015/05/13 ver1.2.0 ログの送りバグ修正
//   2015/05/16 ver1.4.0　swift1.2対応
//                        リファクタリング
//
//  Created by sachin on 2015/04/26.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit

class ViewChat : UIViewController,UITextFieldDelegate{
    
    ///=============================
    ///対象リプリスインスタンス
    private var widget : LiplisWidget!
    
    ///=============================
    ///画面要素
    private var txtChat: UITextField!
    private var btnSend: UIButton!
    
    //=================================
    //リプリスベース設定
    private var baseSetting : LiplisPreference!
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    /*
    コンストラクター
    */
    convenience init(widget : LiplisWidget) {
        self.init(nibName: nil, bundle: nil)
        self.widget = widget
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
    func initClass()
    {
        self.baseSetting = LiplisPreference.SharedInstance
    }
    
    /*
    アクティビティの初期化
    */
    private func initView()
    {
        self.view.opaque = false                                    //背景透過許可
        self.view.backgroundColor = UIColor(white: 0.2,alpha: 0.2)  //白透明背景
    
        //送信テキストラベルの作成
        self.createTxtChat()
        
        //送信ボタン生成
        self.createBtnSend()
        
        //キーボードイベントハンドラ
        self.registerKeyboardEvent()
        
        //サイズ調整
        self.setSize()
        
    }
    
    /*
    チャットテキストの初期化
    */
    private func createTxtChat()
    {
        self.txtChat = UITextField(frame: CGRectMake(0,0,200,30))
        self.txtChat.borderStyle = UITextBorderStyle.RoundedRect
        self.txtChat.text = ""
        self.txtChat.delegate = self
        self.txtChat.becomeFirstResponder()
        self.view.addSubview(txtChat)
    }
    
    /*
    送信ボタンの初期化
    */
    private func createBtnSend()
    {
        self.btnSend = UIButton()
        self.btnSend.frame = CGRectMake(0,0,30,30)
        self.btnSend.layer.masksToBounds = true
        self.btnSend.setTitle("送信", forState: UIControlState.Normal)
        self.self.btnSend.addTarget(self, action: "onClickBtnSend:", forControlEvents: .TouchDown)
        self.btnSend.layer.cornerRadius = 3.0
        self.btnSend.backgroundColor = UIColor.hexStr("A5A5A5", alpha: 255)
        self.view.addSubview(btnSend)
    }
    
    /*
    キーボードイベントの初期化
    */
    private func registerKeyboardEvent()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
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
        //サイズ設定
        self.txtChat.becomeFirstResponder()
        self.setSize()
    }
    
    /*
    メモリーワーニング
    */
    internal override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    エンター入力
    */
    internal func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.sendChat()
        return false
    }
    
    /*
    送信ボタン押下
    */
    internal func onClickBtnSend(sender: AnyObject)
    {
        self.sendChat()
    }
    
    /*
    画面タッチ（閉じる）
    */
    internal override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.closeMe()
    }
    
    /*
    画面を閉じる
    */
    internal func closeMe()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    キーボード表示
    */
    internal func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.btnSend.frame = CGRect(x: 0, y: self.view.frame.height - keyboardSize.height - 67, width: 50, height: 30)
            self.txtChat.frame = CGRect(x: self.btnSend.frame.width, y: self.view.frame.height - keyboardSize.height - 67, width: self.view.frame.width -  self.btnSend.frame.width, height: 30)
        }
    }
    
    /*
    キーボード閉じ時
    */
    internal func keyboardWillHide(notification: NSNotification) {
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
    
    //============================================================
    //
    //おしゃべり処理
    //
    //============================================================
    /*
    チャットテキストを送信する
    */
    internal func sendChat()
    {
        self.widget.chatTalkRecive(txtChat.text)
        self.txtChat.text = ""
    }
    
    
}