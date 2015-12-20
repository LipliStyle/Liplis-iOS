//--------------------------------------------------------
//  ViewController.swift
//  Liplis
//
//  Liplils iOSのデスクトップ画面
//  この画面にキャラクターウィジェットが配置される
//
//
//アップデート履歴
//   2015/01/04 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/14 ver1.3.0　リファクタリング
//   2015/05/16 ver1.4.0　swift1.2対応
//
//  Created by sachin on 2015/01/04.
//  Copyright (c) 2015年 sachin. All rights reserved.
//--------------------------------------------------------

import UIKit

class ViewDeskTop: UIViewController{
    ///=============================
    ///アプリケーションデリゲート
    internal var app : AppDelegate!
    
    ///=============================
    ///キーマネージャー
    internal var kman : LiplisKeyManager!
    
    //=================================
    //リプリスベース設定
    internal var baseSetting : LiplisPreference!
    
    ///=============================
    ///ビュータイトル
    private var viewTitle = "デスクトップマスコット"
    private var tagTitle = "デスクトップ"
    
    //=================================
    //リプリスウィジェット
    private var widgetList: Array<LiplisWidget> = []
    private var trashBox: UIImageView!   //ゴミ箱
    private var trashRect : CGRect!
    private var imgTrash : UIImage!
    private var imgTrashOn : UIImage!
    
    //=================================
    //時計用イメージ
    internal var imgClockBase : UIImage!
    internal var imgClockLongHand : UIImage!
    internal var imgClockShortHand : UIImage!

    //=================================
    //logリスト
    internal var lpsLog : ObjLiplisLogList!
    
    ///=====================================
    /// 移動制御
    internal var flgMoving : Bool = false
    internal var movingIdx : Int! = -1       //移動中ウィジェットのID
    
    //=================================
    //タイマー
    private var clockTimer : NSTimer!
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    
    /*
    コンビニット
    swift1.2対応
    */
    convenience init(app : AppDelegate) {
        self.init(nibName: nil, bundle: nil)
        
        //アプリケーションデリゲート取得
        self.app = app
        
        //クラスの初期化
        self.initClass()
        
        //ビューの初期化
        self.initView()
        
        //リプリスの初期化
        self.initLiplis()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    /*
    画面要素の初期化
    */
    private func initView()
    {
        //ビューの初期化
        let img : UIImage = UIImage(named: ObjR.imgIconDesktop)!                    //アイコン取得
        self.view.opaque = true                                                     //背景透過許可
        self.view.backgroundColor = UIColor(red:255,green:255,blue:255,alpha:255)   //白透明背景
        self.tabBarItem = UITabBarItem(title: tagTitle,image: img, tag: 1)          //タブ設定//アイコン取得
        
        //クロックイメージの初期化
        self.createClockImage()
        
        //トラッシュボックスの作成
        self.createImgTrashBox()
        
        //背景ブラウザの作成
        self.createWebViewBackGround()
        
        //サイズ調整
        self.setSize()
    }
    
    /*
    クロックイメージの初期化
    */
    private func createClockImage()
    {
        //クロックイメージインスタンスの生成
        self.imgClockBase = UIImage(named: ObjR.imgClockBase)
        self.imgClockLongHand = UIImage(named: ObjR.imgClockLongHand)
        self.imgClockShortHand = UIImage(named: ObjR.imgClockShortHand)
    }
    
    /*
    トラッシュボックスの初期化
    */
    private func createImgTrashBox()
    {
        //ごみばこの表示
        self.imgTrash = UIImage(named: ObjR.imgTrash)
        self.imgTrashOn = UIImage(named: ObjR.imgTrashOn)
        self.trashRect = CGRectMake(0,0,0,0)
        self.trashBox = UIImageView(frame:trashRect)
        self.trashBox.image = imgTrash
        self.trashBox.hidden = true
        self.view.addSubview(trashBox)
        self.view.sendSubviewToBack(trashBox)   //表示順序 再背面移動
    }
    
    /*
    背景ブラウザの初期化
    */
    private func createWebViewBackGround()
    {
        //ウェブビュー
        //webBackGround = UIWebView()
        //webBackGround.delegate = self
        //webBackGround.frame = self.view.bounds
        //self.view.addSubview(webBackGround)
        //self.view.sendSubviewToBack(webBackGround)
    }
    
    
    /*
        リプリスの初期化
    */
    private func initLiplis()
    {
        //ウィジェットリストの初期化
        self.widgetList =  Array<LiplisWidget>()
        
        if self.kman.keyList.count == 0
        {
            //キーリストが０件の場合、リリを一個追加して起動
            self.addNewWidget(LiplisSkinData())
        }
        else
        {
            //キーリストを回してウィジェットインスタンスを生成する
            for key in self.kman.keyList
            {
                self.addLoadWidget(key)
            }
        }
    }
    
    /*
        クラスの初期化
    */
    private func initClass()
    {
        //キーマネ
        self.kman = LiplisKeyManager()
        
        //ログの初期化
        self.lpsLog = ObjLiplisLogList()
        
        //ベース設定の取得
        self.baseSetting = LiplisPreference.SharedInstance
        
        //クロックタイマーのスタート
        self.startClockTimer()
    }
    
    //============================================================
    //
    //タイマー処理
    //
    //============================================================
    
    /*
    クロックタイマースタート
    */
    private func startClockTimer()
    {
        //すでに動作中なら破棄しておく
        self.stopClockTimer()
        
        //タイマースタート
        self.clockTimer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: "onClock:", userInfo: nil, repeats: true)
    }
    private func stopClockTimer()
    {
        //すでに起動していたら破棄する
        if self.clockTimer != nil && self.clockTimer.valid
        {
            self.clockTimer.invalidate()
        }
    }
    
    /*
    時計合わせ
    */
    internal func onClock(timer : NSTimer)
    {
        //全てのウィジェットの時計を合わせに行く
        for lips in self.widgetList
        {
            lips.setClock()
        }
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
        self.setSize()
    }
    
    /*
    タッチを感知した際に呼ばれるメソッド.
    */
    internal override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var widgetListIdx : Int = 0
        
        print("touchesBegan")
        
        //ウィジェットのタッチ開始イベントを呼び出す
        for lips in self.widgetList
        {
            if(lips.touchesBegan(touches))
            {
                //ムービングインデックス取得
                self.movingIdx = widgetListIdx
                return
            }
            
            widgetListIdx++
        }
        
        //HITしなければ初期値設定
        self.movingIdx = -1
    }
    
    
    /*
        ドラッグを感知した際に呼ばれるメソッド.
        (ドラッグ中何度も呼ばれる)
    */
    internal override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var widgetListIdx : Int = 0
        
        print("touchesMoved")
        
        //ウィジェットのムーブイベントを呼び出す
        for lips in self.widgetList
        {
            if self.movingIdx == widgetListIdx
            {
                if(lips.touchesMoved(touches))
                {
                    //トラッシュの描画
                    self.onDragTrashMove(touches)
                    
                    return
                }
            }
           
            widgetListIdx++
        }
    }
    
    /*
        ドラッグエンド
    */
    internal override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print("touchesEnded")
        
        //ウィジェットのタッチエンドイベントを呼び出す
        for lips in self.widgetList
        {
            if(lips.touchesEnded(touches))
            {
                self.onDragTrashEnd(lips,touches: touches)
                break
            }
        }
        
        //移動中インデックスの初期化
        self.movingIdx = -1
    }
    
    /*
    トラッシュ表示開始
    */
    internal func onDragTrashBegin()
    {
        //トラッシュボックスの表示
        self.trashBox.hidden = false
        
        //ノーマルトラッシュボックスロード
        self.trashBox.image = self.imgTrash
        
        //アニメーション
        UIView.animateWithDuration(0.1,
            animations: { () -> Void in
                self.trashBox.transform = CGAffineTransformMakeScale(2.0, 2.0)
        })
        
        UIView.animateWithDuration(0.1,
            animations: { () -> Void in
                self.trashBox.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
    }
    
    /*
    トラッシュムーブ
    */
    internal func onDragTrashMove(touches: NSSet)
    {
        // タッチイベントを取得.
        let aTouch = touches.anyObject() as! UITouch
        
        // タッチ位置取得
        let location = aTouch.locationInView(trashBox)
        
        //範囲に入ったらトラッシュボックスを赤くする
        if(location.x >= 0 && location.x <= trashRect.width) && (location.y >= 0 && location.y <= trashRect.height)
        {
            self.trashBox.image = imgTrashOn
        }
        else
        {
            self.trashBox.image = imgTrash
        }
    }
    
    /*
    トラッシュ表示終了
    */
    internal func onDragTrashEnd(widget : LiplisWidget!,touches: NSSet)
    {
        //もし破棄座標にドロップされていたら、対象のウィジェットを削除する
        let aTouch = touches.anyObject() as! UITouch
        let location = aTouch.locationInView(trashBox)
        if(location.x >= -10 && location.x <= trashRect.width + 10) && (location.y >= -10 && location.y <= trashRect.height + 10)
        {
            print("trash!!!!!!!!", terminator: "")
            
            UIView.animateWithDuration(2.0,
                animations: { () -> Void in
                    widget.imgBody.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    widget.imgBody.transform = CGAffineTransformMakeScale(0.0, 0.0)
            })
            
            //ウィジェット削除
            delWidget(widget)
        }
        
        //トラッシュボックス消去アニメーション
        UIView.animateWithDuration(0.1,
            animations: { () -> Void in
                self.trashBox.transform = CGAffineTransformMakeScale(0.4, 0.4)
                self.trashBox.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
        self.trashBox.hidden = true
        self.trashBox.image = self.imgTrash
    }
    
    /*
        メモリーエラーハンドラ
    */
    internal override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    バックグラウンド遷移時
    */
    internal func onBackGround()
    {
        self.widgetSleep()
    }
    
    /*
    フォアグラウンド遷移時
    */
    internal func onForeGround()
    {
        self.widgetWakeup()
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
        //現在のデバイスの向きを取得
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.currentDevice().orientation
        
        //画面サイズ取得
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        //方向別の処理
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            //横向きの判定
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            //縦向きの判定
        }
        
        //画面要素調整
        self.trashRect = CGRectMake(displayWidth/2 - 32, displayHeight - 120,64,64)
        self.trashBox.frame = self.trashRect
        self.view.sendSubviewToBack(self.trashBox)
        self.trashBox.hidden = true
        //self.webBackGround.frame = CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight)
        
        //回転時のレスキュー
        if baseSetting.lpsAutoRescue == 1
        {
            self.rescueWidgetAll()
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
    //ウィジェット処理
    //
    //============================================================
    
    /*
    ウィジェットを追加する(新規追加)
    */
    internal func addNewWidget(lsd : LiplisSkinData)
    {
        //新規キー作成
        let os : ObjPreference = createObjPreferenceFromLsd(lsd)
        
        //ウィジェット
        var lps: LiplisWidget!
        
        //キャラクター名チェック
        if lsd.charDefine == LiplisDefine.SKIN_NAME_DEFAULT
        {
            //デフォリリならデフォルトデータを追加する
            lps = LiplisWidgetDefault(desk:self, os: os, lpsSkinData: lsd)
        }
        else
        {
            //通常のキャラクター名指定なら、スキンデータからウィジェットを生成する
            lps = LiplisWidget(desk:self, os: os,lpsSkinData : lsd)
        }
        
        //ウィジェットリストに追加する
        self.widgetList.append(lps)
        
        //キーマネージャに追加する
        self.kman.addKey(lps.os.key)
    }
    
    /*
    ウィジェットを追加する(読み込み追加)
    */
    internal func addLoadWidget(key : String)
    {
        //キー取得
        let os : ObjPreference = createObjPreferenceFromKey(key)
        
        //スキンデータ取得
        let lsd : LiplisSkinData! = app.cman.getLiplisSkinData(os.charName)
        
        //スキンデータ取得チェック
        if lsd != nil{
            var lps: LiplisWidget!
            
            //キャラクター名チェック
            if os.charName == LiplisDefine.SKIN_NAME_DEFAULT
            {
                //デフォリリならデフォルトデータを追加する
                lps = LiplisWidgetDefault(desk:self, os: os,lpsSkinData: lsd)
            }
            else
            {
                //通常のキャラクター名指定なら、スキンデータからウィジェットを生成する
                lps = LiplisWidget(desk:self, os: os,lpsSkinData: lsd)
            }
            
            //ウィジェットリストに追加する
            self.widgetList.append(lps)
            
            //キーマネージャに追加する
            self.kman.addKey(lps.os.key)
        }
        else
        {
            //スキンデータが削除されている場合は、ウィジェット登録を行わず、キーリストから削除する
            self.kman.addKey(key)
        }
    }
    
    /*
    キーからプリファレンスを読み出す
    */
    private func createObjPreferenceFromKey(key : String)->ObjPreference
    {
        var os : ObjPreference = ObjPreference()
        if key == ""
        {
            //新規作成
            os = ObjPreference()
            
            //初期座標の設定
            os.locationX = Int(self.view.frame.maxX/2)
            os.locationY = Int(self.view.frame.maxY/2)
            
        }
        else
        {
            //キーからロード
            os = ObjPreference(key: key)
        }
        
        return os
    }
    
    /*
    スキンデータからosを作成する
    */
    private func createObjPreferenceFromLsd(lsd : LiplisSkinData)->ObjPreference
    {
        var os : ObjPreference = ObjPreference()
        os = ObjPreference()
        os.charName = lsd.charDefine
        
        //初期座標の設定
        os.locationX = Int(self.view.frame.maxX/2)
        os.locationY = Int(self.view.frame.maxY/2)
                
        return os
    }
    
    
    /*
    ウィジェットをデスクトップに登録する
    */
    internal func registWidget(widget : LiplisWidget)
    {
        self.view.addSubview(widget.imgWindow)
        self.view.addSubview(widget.imgBody)
        self.view.addSubview(widget.lblLpsTalkLabel)
        
        self.view.addSubview(widget.icoSleep)
        self.view.addSubview(widget.icoLog)
        self.view.addSubview(widget.icoSetting)
        self.view.addSubview(widget.icoChat)
        self.view.addSubview(widget.icoClock)
        self.view.addSubview(widget.icoBattery)
        
        self.view.addSubview(widget.imgClockBase)
        self.view.addSubview(widget.imgClockLongHand)
        self.view.addSubview(widget.imgClockShortHand)
    }
    
    
    /*
    ウィジェットをデスクトップから削除する
    */
    internal func delWidget(var widget : LiplisWidget!)
    {
        //ウィジェットのパーツのハッシュと登録オブジェクトのハッシュを比較し、対象を調べる。対象なら削除する。
        for parts in self.view.subviews
        {
            print("View:\(parts.description)")
            
            //対象ウィジェットのパーツだった場合、削除する
            if(parts.hash == widget.imgWindow.hash || parts.hash == widget.imgBody.hash || parts.hash == widget.lblLpsTalkLabel.hash || parts.hash == widget.icoSleep.hash || parts.hash == widget.icoLog.hash || parts.hash == widget.icoSetting.hash || parts.hash == widget.icoChat.hash || parts.hash == widget.icoClock.hash || parts.hash == widget.icoBattery)
            {
                parts.removeFromSuperview()
            }
        }
        
        //キーマネージャーからキーを削除する
        self.kman.delKey(widget.os.key)
        
        //ウィジェットリストから削除する
        self.delFromWidgetList(widget)

        //Liplisオブジェクトの削除
        widget.dispose()
        widget = nil
    }
    
    /*
    デスクトップの全てのウィジェットを削除する
    */
    internal func delWidgetAll()
    {
        for widget in widgetList
        {
            self.delWidget(widget)
        }
        
        //キーは全て削除
        self.kman.delAllKey()
    }
    
    /*
    ウィジェットをウィジェットリストから削除する
    */
    internal func delFromWidgetList(widget : LiplisWidget)
    {
        var idx : Int = 0
        var exists : Bool = false
        
        //ターゲットのインデックスを捜す
        for wid in self.widgetList
        {
            //ハッシュが一致したら抜ける
            if wid.hash == widget.hash
            {
                exists = true
                break
            }
            idx++
        }
        
        //ヒットしたら削除
        if exists
        {
            self.widgetList.removeAtIndex(idx)
        }
    }
    
    /*
    ウィジェットをスリープにする
    */
    internal func widgetSleep()
    {
        //設定チェック
        if (self.baseSetting.lpsAutoSleep == 1)
        {
            //ウィジェットリストを回してらりほー
            for wid in self.widgetList
            {
                wid.sleep()
            }
        }
    }
    
    /*
    ウィジェットをウェイクアップする
    */
    internal func widgetWakeup()
    {
        //設定チェック
        if (self.baseSetting.lpsAutoWakeup == 1)
        {
            //ウィジェットリストを回して起こす
            for wid in self.widgetList
            {
                wid.wakeup()
            }
        }
    }
    
    /*
    デスクトップの全てのウィジェットにレスキューする
    */
    internal func rescueWidgetAll()
    {
        for widget in self.widgetList
        {
            widget.rescue(0)
        }
    }
    
    //============================================================
    //
    //ウェブ処理
    //
    //============================================================
    
    /*
    デスクトップウェブにURLを設定する
    */
    internal func desktopWebSetUrl(url : String)
    {
        // リクエストを作成する.
        //let request: NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
    }
}
