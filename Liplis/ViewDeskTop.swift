//--------------------------------------------------------
//  ViewController.swift
//  Liplis
//
//  Created by sachin on 2015/01/04.
//  Copyright (c) 2015年 sachin. All rights reserved.
//--------------------------------------------------------

import UIKit

class ViewDeskTop: UIViewController{
    ///=============================
    ///アプリケーションデリゲート
    var app : AppDelegate!
    
    ///=============================
    ///キーマネージャー
    var kman : LiplisKeyManager!
    
    //=================================
    //リプリスベース設定
    var baseSetting : LiplisPreference!
    
    //=================================
    //リプリスウィジェット
    var widgetList: Array<LiplisWidget> = []
    var trashBox: UIImageView!   //ゴミ箱
    var trashRect : CGRect!
    var imgTrash : UIImage!
    var imgTrashOn : UIImage!
    var imgClockBase : UIImage!
    var imgClockLongHand : UIImage!
    var imgClockShortHand : UIImage!
    //var webBackGround : UIWebView!
    
    //=================================
    //logリスト
    var lpsLog : ObjLiplisLogList!
    
    ///=====================================
    /// 移動制御
    var flgMoving : Bool = false
    var movingIdx : Int! = -1       //移動中ウィジェットのID
    
    //=================================
    //タイマー
    var clockTimer : NSTimer!
    
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
        initLiplis()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    /*
        画面要素の初期化
    */
    func initView()
    {
        //クロックイメージインスタンスの生成
        imgClockBase = UIImage(named: "ClockBase.png")
        imgClockLongHand = UIImage(named: "ClockLongHand.png")
        imgClockShortHand = UIImage(named: "ClockShortHand.png")
        
        
        var img : UIImage = UIImage(named : "sel_desktop.png")!
        self.tabBarItem = UITabBarItem(title: "デスクトップ",image: img, tag: 1)

        self.view.opaque = true
        self.view.backgroundColor = UIColor(red:255,green:255,blue:255,alpha:255)
     
        let width = self.view.frame.maxX
        let height = self.view.frame.maxY
        
        //ごみばこの表示
        imgTrash = UIImage(named: "trash")
        imgTrashOn = UIImage(named: "trashRed")
        trashRect = CGRectMake(width/2 - 32, height - 120,64,64)
        trashBox = UIImageView(frame:trashRect)
        trashBox.image = imgTrash
        trashBox.hidden = true
    
        //ウェブビュー
        //webBackGround = UIWebView()
        //webBackGround.delegate = self
        //webBackGround.frame = self.view.bounds
        
        self.view.addSubview(trashBox)
        //self.view.addSubview(webBackGround)
        
        //表示順序 再背面移動
        self.view.sendSubviewToBack(trashBox)
        //self.view.sendSubviewToBack(webBackGround)
        
        //サイズ調整
        setSize()
    }
    
    /*
        リプリスの初期化
    */
    func initLiplis()
    {
        //ウィジェットリストの初期化
        widgetList =  Array<LiplisWidget>()
        
        if kman.keyList.count == 0
        {
            //キーリストが０件の場合、リリを一個追加して起動
            addNewWidget(LiplisSkinData())
        }
        else
        {
            //キーリストを回してウィジェットインスタンスを生成する
            for key in kman.keyList
            {
                addLoadWidget(key)
            }
        }
    }
    
    /*
        クラスの初期化
    */
    func initClass()
    {
        //キーマネ
        self.kman = LiplisKeyManager()
        
        //ログの初期化
        lpsLog = ObjLiplisLogList()
        
        //ベース設定の取得
        baseSetting = LiplisPreference.SharedInstance
        
        //クロックタイマーのスタート
        startClockTimer()
    }
    
    //============================================================
    //
    //タイマー処理
    //
    //============================================================
    
    /*
    クロックタイマースタート
    */
    func startClockTimer()
    {
        //すでに動作中なら破棄しておく
        stopClockTimer()
        
        //タイマースタート
        clockTimer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: "onClock:", userInfo: nil, repeats: true)
    }
    func stopClockTimer()
    {
        //すでに起動していたら破棄する
        if clockTimer != nil && clockTimer.valid
        {
            clockTimer.invalidate()
        }
    }
    
    /*
    時計合わせ
    */
    func onClock(timer : NSTimer)
    {
        //全てのウィジェットの時計を合わせに行く
        for lips in widgetList
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    /*
    ビュー呼び出し時
    */
    override func viewWillAppear(animated: Bool) {
        //サイズ設定
        setSize()
    }
    
    /*
    タッチを感知した際に呼ばれるメソッド.
    */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var widgetListIdx : Int = 0
        
        println("touchesBegan")
        
        //ウィジェットのタッチ開始イベントを呼び出す
        for lips in widgetList
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
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var widgetListIdx : Int = 0
        
        println("touchesMoved")
        
        //ウィジェットのムーブイベントを呼び出す
        for lips in widgetList
        {
            if self.movingIdx == widgetListIdx
            {
                if(lips.touchesMoved(touches))
                {
                    //トラッシュの描画
                    onDragTrashMove(touches)
                    
                    return
                }
            }
           
            widgetListIdx++
        }
    }
    
    /*
        ドラッグエンド
    */
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        println("touchesEnded")
        
        //ウィジェットのタッチエンドイベントを呼び出す
        for lips in widgetList
        {
            if(lips.touchesEnded(touches))
            {
                onDragTrashEnd(lips,touches: touches)
                break
            }
        }
        
        //移動中インデックスの初期化
        self.movingIdx = -1
    }
    
    /*
    トラッシュ表示開始
    */
    func onDragTrashBegin()
    {
        self.trashBox.hidden = false
        self.trashBox.image = imgTrash
        UIView.animateWithDuration(0.1,
            // アニメーション中の処理.
            animations: { () -> Void in
                self.trashBox.transform = CGAffineTransformMakeScale(2.0, 2.0)
        })
        
        UIView.animateWithDuration(0.1,
            // アニメーション中の処理.
            animations: { () -> Void in
                self.trashBox.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
    }
    
    /*
    トラッシュムーブ
    */
    func onDragTrashMove(touches: NSSet)
    {
        // タッチイベントを取得.
        let aTouch = touches.anyObject() as UITouch
        
        // タッチ位置取得
        let location = aTouch.locationInView(trashBox)
        
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
    func onDragTrashEnd(var widget : LiplisWidget!,touches: NSSet)
    {
        //もし破棄座標にドロップされていたら、対象のウィジェットを削除する
        let aTouch = touches.anyObject() as UITouch
        let location = aTouch.locationInView(trashBox)
        if(location.x >= -10 && location.x <= trashRect.width + 10) && (location.y >= -10 && location.y <= trashRect.height + 10)
        {
            print("trash!!!!!!!!")
            
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
        self.trashBox.image = imgTrash
    }
    
    /*
        メモリーエラーハンドラ
    */
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    /*
    バックグラウンド遷移時
    */
    func onBackGround()
    {
        widgetSleep()
    }
    
    /*
    フォアグラウンド遷移時
    */
    func onForeGround()
    {
        widgetWakeup()
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
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // 向きの判定.
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            //横向きの判定.
            self.trashRect = CGRectMake(displayWidth/2 - 32, displayHeight - 120,64,64)
            self.trashBox.frame = self.trashRect
            self.view.sendSubviewToBack(self.trashBox)
            self.trashBox.hidden = true
            //self.webBackGround.frame = CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight)
            
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            //縦向きの判定.
            self.trashRect = CGRectMake(displayWidth/2 - 32, displayHeight - 120,64,64)
            self.trashBox.frame = self.trashRect
            self.view.sendSubviewToBack(self.trashBox)
            self.trashBox.hidden = true
            //self.webBackGround.frame = CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight)
        }
        
        //回転時のレスキュー
        if baseSetting.lpsAutoRescue == 1
        {
            rescueWidgetAll()
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
    //ウィジェット処理
    //
    //============================================================
    
    /*
    ウィジェットを追加する(新規追加)
    */
    func addNewWidget(lsd : LiplisSkinData)
    {
        //新規キー作成
        var os : ObjPreference = createObjPreferenceFromLsd(lsd)
        var lps: LiplisWidget!
        
        if lsd.charDefine == LiplisDefine.SKIN_NAME_DEFAULT
        {
            lps = LiplisWidgetDefault(desk:self, os: os, lpsSkinData: lsd)
        }
        else
        {
            lps = LiplisWidget(desk:self, os: os,lpsSkinData : lsd)
        }
        
        widgetList.append(lps)
        kman.addKey(lps.os.key)
    }
    
    /*
    ウィジェットを追加する(読み込み追加)
    */
    func addLoadWidget(key : String)
    {
        var os : ObjPreference = createObjPreferenceFromKey(key)
        var lsd : LiplisSkinData! = app.cman.getLiplisSkinData(os.charName)
        
        if lsd != nil{
            var lps: LiplisWidget!
            
            if os.charName == LiplisDefine.SKIN_NAME_DEFAULT
            {
                lps = LiplisWidgetDefault(desk:self, os: os,lpsSkinData: lsd)
            }
            else
            {
                lps = LiplisWidget(desk:self, os: os,lpsSkinData: lsd)
            }
            
            widgetList.append(lps)
            kman.addKey(lps.os.key)
        }
        else
        {
            //スキンデータが削除されている場合は、ウィジェット登録を行わず、キーリストから削除する
            kman.addKey(key)
        }
    }
    
    /*
    キーからプリファレンスを読み出す
    */
    func createObjPreferenceFromKey(key : String)->ObjPreference
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
    func createObjPreferenceFromLsd(lsd : LiplisSkinData)->ObjPreference
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
    func registWidget(widget : LiplisWidget)
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
    func delWidget(var widget : LiplisWidget!)
    {
        //ウィジェットのパーツのハッシュと登録オブジェクトのハッシュを比較し、対象を調べる。対象なら削除する。
        let views = self.view.subviews
        for (parts: UIView) in views as [UIView]
        {
            println("View:\(parts.description)")
            
            //対象ウィジェットのパーツだった場合、削除する
            if(parts.hash == widget.imgWindow.hash || parts.hash == widget.imgBody.hash || parts.hash == widget.lblLpsTalkLabel.hash || parts.hash == widget.icoSleep.hash || parts.hash == widget.icoLog.hash || parts.hash == widget.icoSetting.hash || parts.hash == widget.icoChat.hash || parts.hash == widget.icoClock.hash || parts.hash == widget.icoBattery)
            {
                parts.removeFromSuperview()
            }
        }
        
        //キーマネージャーからキーを削除する
        kman.delKey(widget.os.key)
        
        //ウィジェットリストから削除する
        delFromWidgetList(widget)

        //Liplisオブジェクトの削除
        widget.dispose()
        widget = nil
    }
    
    /*
    デスクトップの全てのウィジェットを削除する
    */
    func delWidgetAll()
    {
        for widget in widgetList
        {
            delWidget(widget)
        }
        
        //キーは全て削除
        kman.delAllKey()
    }
    
    /*
    ウィジェットをウィジェットリストから削除する
    */
    func delFromWidgetList(widget : LiplisWidget)
    {
        var idx : Int = 0
        var exists : Bool = false
        
        //ターゲットのインデックスを捜す
        for wid in widgetList
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
            widgetList.removeAtIndex(idx)
        }
    }
    
    /*
    ウィジェットをスリープにする
    */
    func widgetSleep()
    {
        //設定チェック
        if (baseSetting.lpsAutoSleep == 1)
        {
            //ウィジェットリストを回してらりほー
            for wid in widgetList
            {
                wid.sleep()
            }
        }
    }
    
    /*
    ウィジェットをウェイクアップする
    */
    func widgetWakeup()
    {
        //設定チェック
        if (baseSetting.lpsAutoWakeup == 1)
        {
            //ウィジェットリストを回して起こす
            for wid in widgetList
            {
                wid.wakeup()
            }
        }
    }
    
    /*
    デスクトップの全てのウィジェットにレスキューする
    */
    func rescueWidgetAll()
    {
        for widget in widgetList
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
    func desktopWebSetUrl(url : String)
    {
        // リクエストを作成する.
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
    }
    

    
}
