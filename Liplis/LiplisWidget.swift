//
//  LiplisWidget.swift
//  Liplis
//
//  ウィジェットのインスタンス
//  ウィジェットの立ち絵、ウインドウ、アイコン等の像イメージを管理し、
//  文字の送り制御、立ち絵の切り替え制御まで行う。
//
//アップデート履歴
//   2015/04/11 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/12 ver1.1.0 リファクタリング
//
//  Created by sachin on 2015/04/11.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit
import Foundation

class LiplisWidget : NSObject {
    //=================================
    //画面要素
    internal var lblLpsTalkLabel: UILabel!
    internal var imgWindow: UIImageView!             //ウインドウ
    internal var imgBody: UIImageView!               //本体画像
    internal var icoSleep : UIButton!                //おやすみアイコン
    internal var icoLog : UIButton!                  //回想アイコン
    internal var icoSetting : UIButton!              //設定アイコン
    internal var icoChat : UIButton!                 //会話アイコン
    internal var icoClock : UIButton!                //時計アイコン
    internal var icoBattery : UIButton!              //バッテリーアイコン
    internal var imgClockBase: UIImageView!          //時計本体画像
    internal var imgClockLongHand: UIImageView!      //時計長針
    internal var imgClockShortHand: UIImageView!     //時計短針
    internal var frame : CGRect!                     //ウィジェットのレクトアングル
    
    //=================================
    //XMLオブジェクト
    internal var lpsSkinData : LiplisSkinData!
    internal var lpsBody : ObjLiplisBody!
    internal var lpsChat : ObjLiplisChat!
    internal var lpsIcon : ObjLiplisIcon!
    internal var lpsSkin : ObjLiplisSkin!
    internal var lpsTouch : ObjLiplisTouch!
    internal var lpsVer : ObjLiplisVersion!
    
    //=================================
    //ロードボディオブジェクト
    internal var ob : ObjBody!
    
    //=================================
    //キャラクター設定
    internal var os : ObjPreference!
    
    //=================================
    //デスクトップインスタンス
    internal var desk:ViewDeskTop!
    
    //=================================
    //ニュースインスタンス
    internal var lpsNews : LiplisNews!
    internal var lpsBattery : ObjBattery!
    internal var lpsChatTalk : LiplisApiChat!
    
    //=================================
    //タイマー
    internal var updateTimer : NSTimer!
    internal var nextTimer : NSTimer!
    internal var startMoveTimer : NSTimer!
    internal var flgAlarm : Int! = 0
    
    //=================================
    //制御プロパティ
    internal var liplisNowTopic : MsgShortNews!  //現在ロードおしゃべりデータ
    internal var liplisNowWord : String = ""     //ロード中の単語
    internal var liplisChatText : String = ""    //テキストバッファ
    internal var liplisUrl : String = ""         //現在ロード中の記事のURL
    internal var cntLct : Int! = 0               //チャットテキストカウント
    internal var cntLnw : Int! = 0               //ナウワードカウント
    internal var nowPoint : Int! = 0             //現在感情レベル
    internal var nowPos : Int! = 0               //現在品詞
    internal var nowEmotion : Int! = 0           //現在感情
    internal var prvEmotion : Int! = 0           //前回感情
    internal var cntMouth : Int! = 0             //口パクカウント
    internal var cntBlink  : Int! = 0            //まばたきカウント
    internal var nowBlink    : Int! = 0          //現在目のオープン状態
    internal var prvBlink    : Int! = 0          //１つ前の目のオープン状態
    internal var nowDirection : Int! = 0         //現在の方向
    internal var prvDirection  : Int = 0         //１つ前の方向
    internal var cntSlow  : Int! = 0             //スローカウント

    //=================================
    //制御フラグ
    internal var flgConnect     : Bool = false   //接続フラグ
    internal var flgBodyChencge : Bool = false   //ボディ変更フラグ
    internal var flgChatting    : Bool = false   //おしゃべり中フラグ
    internal var flgSkip        : Bool = false   //スキップフラグ
    internal var flgSkipping    : Bool = false   //スキップ中フラグ
    internal var flgSitdown     : Bool = false   //おすわり中フラグ
    internal var flgThinking    : Bool = false   //考え中フラグ
    internal var flgEnd         : Bool = false   //おしゃべり終了フラグ
    internal var flgTag         : Bool = false   //タグチェック
    internal var flgChatTalk    : Bool = false   //
    internal var flgDebug       : Bool = false   //
    internal var flgOutputDemo  : Bool = false   //
    
    ///=====================================
    /// 設定値
    //NOTE : liplisRefreshRate * liplisRate = 更新間隔 (updateCntに関連)
    internal var liplisInterval : Int! = 100;		    //インターバル
    internal var liplisRefresh : Int! = 10;			//リフレッシュレート
    
    ///=====================================
    /// 時報制御
    internal var prvHour : Int = 0
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    デフォルトイニシャライザ
    */
    init(desk:ViewDeskTop!, os : ObjPreference, lpsSkinData : LiplisSkinData!)
    {
        //スーパーイニット
        super.init()
        
        //設定データ
        self.os = os
        
        //デスクトップクラス取得
        self.desk = desk
        
        //スキンデータ取得
        self.lpsSkinData = lpsSkinData
        
        //XMLの読み込み
        self.initXml()
        
        //クラスの初期化
        self.initClass()
        
        //ビューの初期化
        self.initView()

        //あいさつ
        self.greet()
    }
    
    /*
        画面要素の初期化
    */
    func initView()
    {
        //画面サイズの取得
        let width = desk.view.frame.maxX
        let height = desk.view.frame.maxY

        // UIImageViewを作成する.
        self.lblLpsTalkLabel = UILabel(frame: CGRectMake(0, 0, 140, 60))
        self.imgWindow = UIImageView(frame: CGRectMake(0,0,150,60))
        self.imgBody = UIImageView(frame: CGRectMake(0,0,self.lpsBody.widthReal,self.lpsBody.heightReal))
        self.icoSleep = UIButton(frame: CGRectMake(0,0,32,32))
        self.icoLog = UIButton(frame: CGRectMake(0,0,32,32))
        self.icoSetting = UIButton(frame: CGRectMake(0,0,32,32))
        self.icoChat = UIButton(frame: CGRectMake(0,0,32,32))
        self.icoClock = UIButton(frame: CGRectMake(0,0,32,32))
        self.icoBattery = UIButton(frame: CGRectMake(0,0,32,32))
        
        self.imgClockBase = UIImageView(frame: CGRectMake(0,0,32,32))
        self.imgClockLongHand = UIImageView(frame: CGRectMake(0,0,32,32))
        self.imgClockShortHand = UIImageView(frame: CGRectMake(0,0,32,32))
        
        // 画像をUIImageViewに設定する.
        //imgWindow.image = UIImage(named: os.lpsWindowColor)
        self.imgBody.image = UIImage(named: lpsBody.normalList[0].eye_1_c)
        self.icoSleep.setImage(lpsIcon.imgSleep,forState : UIControlState.Normal)
        self.icoLog.setImage(lpsIcon.imgLog, forState: UIControlState.Normal)
        self.icoSetting.setImage(lpsIcon.imgSetting, forState: UIControlState.Normal)
        self.icoChat.setImage(lpsIcon.imgIntro, forState: UIControlState.Normal)
        self.icoClock.setImage(lpsIcon.imgBack, forState: UIControlState.Normal)
        self.icoBattery.setImage(lpsIcon.imgBattery_100, forState: UIControlState.Normal)
        
        self.imgClockBase.image = desk.imgClockBase
        self.imgClockLongHand.image = desk.imgClockLongHand
        self.imgClockShortHand.image = desk.imgClockShortHand
        
        //ウインドウイメージのセット
        self.setWindow()
        
        //ラベル設定
        self.lblLpsTalkLabel.text = ""                               //初期テキスト　空
        self.lblLpsTalkLabel.font = UIFont.systemFontOfSize(10)      //フォントサイズ
        self.lblLpsTalkLabel.numberOfLines = 6                       //行数 6
        
        // 画像の表示する座標を指定する.　初期表示　暫定中央
        self.imgBody.layer.position = CGPoint(x: os.locationX, y: os.locationY)
        self.setWidgetLocation(-10, windowOffsetY: 5)
        
        //イベントハンドラマッピング
        self.icoSleep.addTarget(self, action: "onDownIcoSleep:", forControlEvents: .TouchDown)
        self.icoSleep.addTarget(self, action: "onUpIcoSleep:", forControlEvents: .TouchUpInside | .TouchUpOutside)
        self.icoLog.addTarget(self, action: "onDownIcoLog:", forControlEvents: .TouchDown)
        self.icoLog.addTarget(self, action: "onUpIcoLog:", forControlEvents: .TouchUpInside | .TouchUpOutside)
        self.icoSetting.addTarget(self, action: "onDownIcoSetting:", forControlEvents: .TouchDown)
        self.icoSetting.addTarget(self, action: "onUpIcoSetting:", forControlEvents: .TouchUpInside | .TouchUpOutside)
        self.icoChat.addTarget(self, action: "onDownIcoChat:", forControlEvents: .TouchDown)
        self.icoChat.addTarget(self, action: "onUpIcoChat:", forControlEvents: .TouchUpInside | .TouchUpOutside)
        self.icoClock.addTarget(self, action: "onDownIoClock:", forControlEvents: .TouchDown)
        self.icoClock.addTarget(self, action: "onUpIoClock:", forControlEvents: .TouchUpInside | .TouchUpOutside)
        self.icoBattery.addTarget(self, action: "onDownIcoBattery:", forControlEvents: .TouchDown)
        self.icoBattery.addTarget(self, action: "onUpIcoBattery:", forControlEvents: .TouchUpInside | .TouchUpOutside)
        
        //要素の登録はデスクトップで行う
        self.desk.registWidget(self)
        
        self.setClock()
    }
    
    /*
    XML読み込み
    オーバーライドが必要
    */
    func initXml()
    {
        //ボディインスタンス
        lpsSkin = self.lpsSkinData.lpsSkin
        lpsChat = ObjLiplisChat(url:self.lpsSkinData.xmlChat)
        lpsBody = ObjLiplisBody(url:self.lpsSkinData.xmlBody, bodyPath: lpsSkinData.pathBody)
        lpsTouch = ObjLiplisTouch(url:self.lpsSkinData.xmlTouch)
        lpsVer = ObjLiplisVersion(url:self.lpsSkinData.xmlVersion)
        lpsIcon = ObjLiplisIcon(windowPath: self.lpsSkinData.pathWindow)
    }
    
    /*
    クラスの初期化
    */
    func initClass()
    {
        //デフォルトボディロード
        ob = lpsBody.getDefaultBody()
        
        //ニュースの初期化
        lpsNews = LiplisNews()
        
        //話題収集の実行
        onCheckNewsQueue()
        
        //バッテリーオブジェクトの初期化
        lpsBattery = ObjBattery()
            
        //チャットAPIインスタンス
        lpsChatTalk = LiplisApiChat()
    }

    /*
        チャット情報の初期化
    */
    func initChatInfo()
    {
        //チャットテキストの初期化
        liplisChatText = ""
        
        //なうワードの初期化
        liplisNowWord = ""
        
        //ナウ文字インデックスの初期化
        cntLct = 0
        
        //ナウワードインデックスの初期化
        cntLnw = 0
    }
    
    /*
    ウインドウのセット
    オーバーライドが必要
    */
    func setWindow()
    {
        imgWindow.image = UIImage(contentsOfFile: self.lpsSkinData.pathWindow + "/" + os.lpsWindowColor)
    }
    
    /*
    時計のセット
    */
    func setClock()
    {
        //現在日時取得
        let date : LiplisDate = LiplisDate()
        
        imgClockLongHand.image = desk.imgClockLongHand
        imgClockShortHand.image = desk.imgClockShortHand
        
        //現在分の計算
        let dblkeikaMin : Double = Double(60 * date.hour! + date.minute!)
        let dblMin : Double = Double(date.minute!)
        
        //角度の計算
        let argHour = CGFloat((2 * M_PI * dblkeikaMin) / (60 * 12))
        let argMin = CGFloat((2 * M_PI * dblMin)/60)
        
        //時計セット
        imgClockShortHand.transform = CGAffineTransformMakeRotation(argHour)
        imgClockLongHand.transform = CGAffineTransformMakeRotation(argMin)
        
    }
    
    //============================================================
    //
    //終了処理
    //
    //============================================================
    deinit
    {
        dispose()
    }
    
    /*
    破棄
    */
    func dispose()
    {
        //プリファレンスの破棄
        self.os.delPreference()
            
        //タイマー停止
        self.stopNextTimer()
        self.stopUpdateTimer()
       
        //イメージの破棄
        if self.imgWindow != nil {self.imgWindow.image = nil}
        if self.imgBody != nil {self.imgBody.image = nil}
        
        if self.icoSleep != nil {self.icoSleep.setImage(nil,forState : UIControlState.Normal)}
        if self.icoLog != nil {self.icoLog.setImage(nil ,forState: UIControlState.Normal)}
        if self.icoSetting != nil {self.icoSetting.setImage(nil, forState: UIControlState.Normal)}
        if self.icoChat != nil {self.icoChat.setImage(nil, forState: UIControlState.Normal)}
        if self.icoClock != nil {self.icoClock.setImage(nil, forState: UIControlState.Normal)}
        if self.icoBattery != nil {self.icoBattery.setImage(nil, forState: UIControlState.Normal)}
        
        if self.imgClockBase != nil {self.imgClockBase.image = nil}
        if self.imgClockLongHand != nil {self.imgClockLongHand.image = nil}
        if self.imgClockShortHand != nil {self.imgClockShortHand.image = nil}
            
        //要素の破棄
        self.lblLpsTalkLabel = nil
        self.imgWindow = nil
        self.imgBody = nil
        self.icoSleep = nil
        self.icoClock = nil
        self.icoLog = nil
        self.icoSetting = nil
        self.icoChat = nil
        self.icoBattery = nil
        self.imgClockBase = nil
        self.imgClockLongHand = nil
        self.imgClockShortHand = nil
        
        //タイマーの破棄
        self.nextTimer = nil
        self.updateTimer = nil
    }
    
    
    //============================================================
    //
    //タイマー処理
    //
    //============================================================
    
    /*
    アップデートタイマースタート
    */
    func startUpdateTimer()
    {
        //すでに動作中なら破棄しておく
        stopUpdateTimer()
        
        //タイマースタート
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
    }
    func stopUpdateTimer()
    {
        //すでに起動していたら破棄する
        if updateTimer != nil && updateTimer.valid
        {
            updateTimer.invalidate()
        }
    }
    
    /*
    ネクストタイマースタート
    */
    func startNextTimer(pInterval : Double)
    {
        //すでに動作中なら破棄しておく
        stopNextTimer()
        
        //タイマースタート
        nextTimer = NSTimer.scheduledTimerWithTimeInterval(pInterval, target: self, selector : "onNext:", userInfo: nil, repeats: true)
    }
    func stopNextTimer()
    {
        //すでに起動していたら破棄する
        if nextTimer != nil && nextTimer.valid
        {
            nextTimer.invalidate()
        }
    }
    /*
    ドラッグ移動開始タイマー
    */
    func startStartMoveTimer()
    {
        //すでに動作中なら破棄しておく
        stopStartMoveTimer()
        
        //タイマースタート
        startMoveTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector : "onstartMove:", userInfo: nil, repeats: true)
    }
    func stopStartMoveTimer()
    {
        //すでに起動していたら破棄する
        if startMoveTimer != nil && startMoveTimer.valid
        {
            startMoveTimer.invalidate()
        }
    }
    
    /*
        おしゃべりタイマー
        10秒間隔で実行
        おしゃべり中は停止する
    */
    func onNext(timer : NSTimer)
    {
        if os.lpsDisplayIcon == 0
        {
            iconOff()
        }
        
        nextLiplis()
    }
    
    
    /*
        おしゃべりタイマー
        0.1間隔で実行
    */
    func onUpdate(timer : NSTimer)
    {
        if(flgAlarm == 12)
        {
            updateLiplis()
        }
    }
    
    
    /*
        アップデートカウントのリセット
    */
    func reSetUpdateCount()
    {
        //無口の場合はタイマーを更新しない
        if os.lpsMode == 3
        {
            //すでに動作中なら破棄しておく
            stopNextTimer()
            return
        }
        
        if !flgChatTalk
        {
            startNextTimer(os.lpsInterval)
        }
        else
        {
            startNextTimer(60.0)
        }
    }
    
    /*
    ドラッグ移動開始タイマー
    タップしてから３秒後に実行
    */
    func onstartMove(timer : NSTimer)
    {
        startMove()
        stopStartMoveTimer()
    }
    
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    /*
        タッチ開始イベント
    */
    func touchesBegan(touches: NSSet)->Bool {
        //フレーム取得
        var frameImgBody: CGRect = imgBody.frame
        
        // タッチイベントを取得.
        let aTouch = touches.anyObject() as UITouch
        
        // タッチ位置の取得
        let location = aTouch.locationInView(imgBody)

        //範囲チェック
        if((location.x >= 0 && location.x <= frameImgBody.width) && (location.y >= 0 && location.y <= frameImgBody.height))
        {
            // Labelアニメーション.
            UIView.animateWithDuration(0.06,
                // アニメーション中の処理.
                animations: { () -> Void in
                    // 縮小用アフィン行列を作成する.
                    self.imgBody.transform = CGAffineTransformMakeScale(0.9, 0.9)
                })
            { (Bool) -> Void in}
            
            //移動制御タイマー開始
            startStartMoveTimer()
            
            return true
        }
        
        //ウインドウフレーム取得
        var frameImgWindow : CGRect = imgWindow.frame
        
        //ウインドウクリックモードチェック
        if(desk.baseSetting.lpsTalkWindowClickMode == 1)
        {
            // ウインドウタッチ位置の取得
            let locationWindow = aTouch.locationInView(imgWindow)
            
            if((locationWindow.x >= 0 && locationWindow.x <= frameImgWindow.width) && (locationWindow.y >= 0 && locationWindow.y <= frameImgWindow.height))
            {
                UIView.animateWithDuration(0.06,
                    animations: { () -> Void in
                        self.imgWindow.transform = CGAffineTransformMakeScale(0.9, 0.9)
                    })
                    

                return true
            }
        }

        return false
    }
    
    /*
        ドラッグイベント
    */
    func touchesMoved(touches: NSSet)->Bool  {
        if(desk.flgMoving)
        {
            // タッチイベントを取得.
            let aTouch = touches.anyObject() as UITouch
            
            //ボディフレーム
            var frameImgBody : CGRect = imgBody.frame
            
            // 移動した先の座標を取得.
            let location = aTouch.locationInView(imgBody)
            
            if((location.x >= 0 && location.x <= frameImgBody.width) && (location.y >= 0 && location.y <= frameImgBody.height))
            {
                //フレーム取得
        
                // 移動する前の座標を取得.
                let prevLocation = aTouch.previousLocationInView(imgBody)
                
                //移動量計算
                let deltaX: CGFloat = location.x - prevLocation.x
                let deltaY: CGFloat = location.y - prevLocation.y
                
                // 移動した分の距離をmyFrameの座標にプラスする.
                imgBody.frame.origin.x += deltaX
                imgBody.frame.origin.y += deltaY

                //ほかパーツの追随
                setWidgetLocation(0,windowOffsetY : 0)
         
                return true
            }
        }

        return false
    }
    
    /*
        タッチ終了イベント
    */
    func touchesEnded(touches: NSSet)->Bool  {
        //フレーム取得
        var frameImgBody : CGRect = imgBody.frame
            
        // タッチイベントを取得.
        let aTouch = touches.anyObject() as UITouch
            
        // タッチ位置取得
        let location = aTouch.locationInView(imgBody)
            
        if(location.x >= 0 && location.x <= frameImgBody.width) && (location.y >= 0 && location.y <= frameImgBody.height)
        {
            //タッチ位置保存
            self.saveLocation()
            
            // Labelアニメーション.
            UIView.animateWithDuration(0.1,
            // アニメーション中の処理.
            animations: { () -> Void in
           
                // 拡大用アフィン行列を作成する.
                self.imgBody.transform = CGAffineTransformMakeScale(0.4, 0.4)
                // 縮小用アフィン行列を作成する.
        
                self.imgBody.transform = CGAffineTransformMakeScale(1.0, 1.0)
                
            })
            
            //クリックイベント
            self.onClickBody()
            
            //レスキュー
            if self.desk.baseSetting.lpsAutoRescue == 1
            {
                rescue(40)
            }
            
            
            //移動終了
            desk.flgMoving = false
            
            //移動制御タイマーを破棄しておく
            stopStartMoveTimer()
            
            return true
        }
        
        //ウインドウフレーム取得
        var frameImgWindow : CGRect = imgWindow.frame
        
        if(desk.baseSetting.lpsTalkWindowClickMode == 1)
        {
            // タッチ位置の表示
            let locationWindow = aTouch.locationInView(imgWindow)
            
            if((locationWindow.x >= 0 && locationWindow.x <= frameImgWindow.width) && (locationWindow.y >= 0 && locationWindow.y <= frameImgWindow.height))
            {
                UIView.animateWithDuration(0.06,
                    animations: { () -> Void in
                        self.imgWindow.transform = CGAffineTransformMakeScale(0.4, 0.4)
                        self.imgWindow.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        self.onClickWindow()
                    })
                return true
            }
        }

        return false
    }
    
    func setWidgetLocation(offsetY : CGFloat, windowOffsetY : CGFloat)
    {
        //ボディフレーム
        var frameImgBody : CGRect = imgBody.frame
        
        var frameImgWindow : CGRect = imgWindow.frame
        var frameLblTalkLabel : CGRect = lblLpsTalkLabel.frame
        
        var frameIcoSleep: CGRect = icoSleep.frame
        var frameIcoLog: CGRect = icoLog.frame
        var frameIcoSetting: CGRect = icoSetting.frame
        var frameIcoChat: CGRect = icoChat.frame
        var frameIcoClock: CGRect = icoClock.frame
        var frameIcoBattery: CGRect = icoBattery.frame
        
        frameImgWindow.origin.x = frameImgBody.origin.x - frameImgWindow.width/2 + frameImgBody.width/2
        frameImgWindow.origin.y = frameImgBody.origin.y - 45  + windowOffsetY
        frameLblTalkLabel.origin.x = frameImgBody.origin.x - frameImgWindow.width/2 + frameImgBody.width/2 + 5
        frameLblTalkLabel.origin.y = frameImgBody.origin.y - 45  + windowOffsetY
        
        frameIcoSleep.origin.x = frameImgWindow.origin.x
        frameIcoSleep.origin.y = frameImgBody.origin.y + frameImgBody.height - 112 + offsetY
        frameIcoLog.origin.x = frameImgWindow.origin.x
        frameIcoLog.origin.y = frameImgBody.origin.y + frameImgBody.height - 72 + offsetY
        frameIcoSetting.origin.x = frameImgWindow.origin.x
        frameIcoSetting.origin.y = frameImgBody.origin.y + frameImgBody.height - 32 + offsetY
        frameIcoChat.origin.x = frameImgWindow.origin.x + frameImgWindow.width-32
        frameIcoChat.origin.y = frameImgBody.origin.y + frameImgBody.height - 112 + offsetY
        frameIcoClock.origin.x = frameImgWindow.origin.x + frameImgWindow.width-32
        frameIcoClock.origin.y = frameImgBody.origin.y + frameImgBody.height-72 + offsetY
        frameIcoBattery.origin.x = frameImgWindow.origin.x + frameImgWindow.width-32
        frameIcoBattery.origin.y = frameImgBody.origin.y + frameImgBody.height - 32 + offsetY
        
        // frameにmyFrameを追加.
        imgWindow.frame = frameImgWindow
        lblLpsTalkLabel.frame = frameLblTalkLabel
        
        imgClockBase.frame = frameIcoClock
        imgClockLongHand.frame = frameIcoClock
        imgClockShortHand.frame = frameIcoClock
        
        icoSleep.frame = frameIcoSleep
        icoLog.frame = frameIcoLog
        icoSetting.frame = frameIcoSetting
        icoChat.frame = frameIcoChat
        icoClock.frame = frameIcoClock
        icoBattery.frame = frameIcoBattery
        
        //レクトの設定
        self.frame = CGRect(x: frameImgWindow.origin.x, y: frameImgWindow.origin.y, width: frameImgWindow.width, height: frameIcoSetting.origin.y + frameIcoSetting.height - frameImgWindow.origin.y)
    }
    
    
    /*
    移動開始処理
    */
    func startMove()
    {
        // Labelアニメーション.
        UIView.animateWithDuration(0.06,
        animations: { () -> Void in
            self.imgBody.transform = CGAffineTransformMakeScale(0.4, 0.4)
            self.imgBody.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.imgBody.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
        
        //ウィジェットを最前面に移動する
        goToTheFront()
        
        //移動開始
        desk.flgMoving = true
        desk.onDragTrashBegin()
    }
    
    /*
        ボディクリック時処理
    */
    func onClickBody()
    {
        if(!flgChatting)
        {
            //チャット中でなければ、次の話題おしゃべり
            nextLiplis()
        }
        else
        {
            //チャット中ならスキップする
            flgSkip = true
        }
        
        //アイコンを有効にする
        iconOn()
        
        setClock()
    }
    
    /*
    ウインドウクリック時処理
    */
    func onClickWindow()
    {
        if(liplisUrl != "")
        {
            if desk.baseSetting.lpsBrowserMode == 0
            {
                //URL設定
                self.desk.app.activityWeb.url = NSURL(string: self.liplisUrl)!
                
                //タブ移動
                self.desk.tabBarController?.selectedIndex=4
            }
            else  if desk.baseSetting.lpsBrowserMode == 1
            {
                let nurl = NSURL(string: liplisUrl)
                if UIApplication.sharedApplication().canOpenURL(nurl!){
                    UIApplication.sharedApplication().openURL(nurl!)
                }
            }
            else  if desk.baseSetting.lpsBrowserMode == 2
            {
                //URL設定
                self.desk.desktopWebSetUrl(self.liplisUrl)
            }
        }
    }
    
    /*
    おやすみボタン押下時処理
    */
    func onClickSleep()
    {
        if flgSitdown
        {
            wakeup()
        }
        else
        {
            sleep()
        }
    }
    
    /*
    ウィジェットをデスクトップ内に復帰させる
    */
    func rescue(offset : Int)
    {
        //X軸範囲チェック
        if self.frame.origin.x < CGFloat(offset * -1)   //-40
        {
            imgBody.frame.origin.x = 10 + (imgWindow.frame.width/2 - imgBody.frame.width/2)
        }
        else if self.frame.origin.x >= self.desk.view.frame.width - self.frame.width + CGFloat(offset) //40
        {
            imgBody.frame.origin.x = self.desk.view.frame.width - self.frame.width + (imgWindow.frame.width/2 - imgBody.frame.width/2) - 10
        }
        
        //Y軸範囲チェック
        if self.frame.origin.y < CGFloat(offset * -1)   //-40
        {
            imgBody.frame.origin.y = 50
        }
        else if self.frame.origin.y > self.desk.view.frame.height - self.frame.height + CGFloat(offset/2) //20
        {
            imgBody.frame.origin.y = self.desk.view.frame.height - self.frame.height - 80
        }

        //パーツの位置調整
        self.setWidgetLocation(-10, windowOffsetY: 5)
        
        //座標セーブ
        self.saveLocation()
    }

    /*
    座標をセーブルする
    */
    func saveLocation()
    {
        os.locationX = Int(imgBody.layer.position.x)
        os.locationY = Int(imgBody.layer.position.y)
        os.saveSetting()
    }
    
    
    //============================================================
    //
    //ボタンイベント
    //
    //============================================================
    
    /*
    スリープボタンイベント
    */
    func onDownIcoSleep(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
            self.icoSleep.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
        onClickSleep()
    }
    func onUpIcoSleep(sender: UIButton){
        UIView.animateWithDuration(0.1,animations: { () -> Void in
        self.icoSleep.transform = CGAffineTransformMakeScale(0.4, 0.4)
        self.icoSleep.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
    }
    
    /*
    ログボタンイベント
    */
    func onDownIcoLog(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
        self.icoLog.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
    }
    func onUpIcoLog(sender: UIButton){
            UIView.animateWithDuration(0.1,animations: { () -> Void in
            self.icoLog.transform = CGAffineTransformMakeScale(0.4, 0.4)
            self.icoLog.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
            
            //タブ移動 ログ画面
            self.desk.tabBarController?.selectedIndex=3
    }
    
    /*
    設定ボタンイベント
    */
    func onDownIcoSetting(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
        self.icoSetting.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
    }
    func onUpIcoSetting(sender: UIButton){
                UIView.animateWithDuration(0.1,animations: { () -> Void in
            self.icoSetting.transform = CGAffineTransformMakeScale(0.4, 0.4)
            self.icoSetting.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
        callWidgetSetting()
    }
    
    /*
    チャットボタンイベント
    */
    func onDownIcoChat(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
        self.icoChat.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
    }
    func onUpIcoChat(sender: UIButton){
        UIView.animateWithDuration(0.1,animations: { () -> Void in
        self.icoChat.transform = CGAffineTransformMakeScale(0.4, 0.4)
        self.icoChat.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
        callChat()

    }

    /*
    クロックボタンイベント
    */
    func onDownIoClock(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
        self.icoClock.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
        clockInfo()
    }
    func onUpIoClock(sender: UIButton){
            UIView.animateWithDuration(0.1,animations: { () -> Void in
            self.icoClock.transform = CGAffineTransformMakeScale(0.4, 0.4)
            self.icoClock.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
        
    }
    
    /*
    バッテリーボタンイベント
    */
    func onDownIcoBattery(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
        self.icoBattery.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
        batteryInfo()
    }
    func onUpIcoBattery(sender: UIButton){
            UIView.animateWithDuration(0.1,animations: { () -> Void in
            self.icoBattery.transform = CGAffineTransformMakeScale(0.4, 0.4)
            self.icoBattery.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
    }

    //============================================================
    //
    //定型おしゃべり
    //
    //============================================================

    /*
        挨拶
    */
    func greet()
    {
        liplisNowTopic = lpsChat.getGreet()
        
        if liplisNowTopic.getMessage() == ""
        {
            liplisNowTopic = MsgShortNews(name: "なうろーでぃんぐ♪",emotion: 0,point: 0)
        }
        
        //チャット情報の初期化
        initChatInfo()
        
        //チャットスタート
        chatStart()
    }
    
    /*
        バッテリー情報おしゃべり
    */
    func batteryInfo()
    {
        //座り中なら回避
        if(flgSitdown){return}
        
        //挨拶の選定
        liplisNowTopic = lpsChat.getBatteryInfo(Int(lpsBattery.batteryNowLevel * 100))
           
        //チャット情報の初期化
        initChatInfo()
                
        //チャットスタート
        chatStart()
    }
    
    /*
    時刻情報おしゃべり
    */
    func clockInfo()
        {
        //座り中なら回避
        if(flgSitdown){return}
        
        //挨拶の選定
        liplisNowTopic = lpsChat.getClockInfo()
            
        //チャット情報の初期化
        initChatInfo()
            
        //チャットスタート
        chatStart()
    }
    
    /*
        時報チェック
    */
    func onTimeSignal()->Bool
    {
        var result : Bool = false
        var nowHour : Int = getHour()
        
        if(nowHour != self.prvHour)
        {
            //座り中なら回避
            if(self.flgSitdown){return false}
            
            //時報取得
            self.liplisNowTopic = self.lpsChat.getTimeSignal(nowHour)
            
            //時報データが無い場合は時報をおしゃべりしない
            if self.liplisNowTopic == nil
            {
                self.prvHour = getHour()
                return false
            }
            
            //チャット情報の初期化
            self.initchatInfo()
            
            //おしゃべりスタート
            self.chatStart()
            
            result = true
        }
        //前回時刻のセット
        self.prvHour = self.getHour()
        
        return result
    }
    
    /*
    時刻取得
    */
    func getHour()->Int{
        var date : LiplisDate = LiplisDate()
        return date.hour!
    }
    
    /*
    話しかけ取得
    */
    func chatTalkRecive(chatText : String)
    {
        //座り中なら回避
        if(flgSitdown){return}
        
        //挨拶の選定
        liplisNowTopic = lpsChatTalk.apiPost(desk.baseSetting.lpsUid, toneUrl: lpsSkin.tone,version: "I" + LiplisUtil.getAppVersion(),sentence: chatText)
            
        //チャット情報の初期化
        initChatInfo()
        
        //チャットスタート
        chatStart()
    }
    
    
    //============================================================
    //
    //おしゃべり準備処理
    //
    //============================================================
    /*
        チャット情報の初期化
    */
    func initchatInfo()
    {
        //チャットテキストの初期化
        liplisChatText = ""
        
        //ナウワードの初期化
        liplisNowWord = ""
        
        //ナウ文字インデックスの初期化
        cntLct = 0
        
        //なうワードインデックスの初期化
        cntLnw = 0
    }
    
    /*
        話題残量チェック
    */
    func checkRunout()->Bool
    {
        return (os.lpsNewsRunOut == 1) && lpsNews.checkNewsQueueCount(getPostDataForLiplisNewsList())
    }
    
    //============================================================
    //
    //おしゃべり処理
    //
    //============================================================

    /*
        次の話題
    */
    func nextLiplis()
    {
        flgAlarm = 0
        
        //バッテリーチェック
        icoBattery.setImage(lpsIcon.getBatteryIcon(lpsBattery.getBatteryRatel()),  forState: UIControlState.Normal)
        
        //おすわりチェック
        if(flgSitdown){
            stopNextTimer()
            stopUpdateTimer()
            return
        }
        
        //URLの初期化
        liplisUrl = ""
        
        if(os.lpsMode == 0 || os.lpsMode == 1 || os.lpsMode == 2)
        {
            if(onTimeSignal())
            {
                return
            }
            
            if(checkRunout())
            {
                reSetUpdateCount()
                return
            }
            
            runLiplis()
        }
        else if(os.lpsMode == 3)
        {
            runLiplis()
        }
        else if(os.lpsMode == 4)
        {
            //時計＆バッテリー(ios版ではなし)
        }
    }
    
    func runLiplis()
    {
        //チャット中なら終了する
        if(flgChatting){chatStop();return}
        
        //座り中なら回避
        if(flgSitdown){chatStop();return}
        
        //ウインドウチェック ウインドウが消える仕様は保留する
        //windowsOn()
        
        //クロックチェック
        //ios版では時計表示なし
        
        //アイコンカウント
        //iconCloseCheck()
        
        //立ち絵をデフォルトに戻す
        setObjectBodyNeutral()
        
        //トピックを取得する
        getTopic()
        
        //チャット情報の初期化
        initChatInfo()
        
        //チャットスタート
        chatStart()
    }
    
    
    /*
        リプリスの更新
    */
    func updateLiplis()
    {
        switch(os.lpsSpeed)
        {
        case 0 :
            if(flgAlarm != 0){refreshLiplis()}
            break
        case 1 :
            if(cntSlow >= 1)
            {
                refreshLiplis()
                cntSlow = 0
            }
            else
            {
                cntSlow = cntSlow + 1
            }
            break
        case 2 :
            if(cntSlow >= 2)
            {
                refreshLiplis()
                cntSlow = 0
            }
            else
            {
                cntSlow = cntSlow + 1
            }
            break
        case 3 :
            immediateRefresh()
            break
        default :
            immediateRefresh()
            break
        }
    }
    
    /*
        リフレッシュ
    */
    func refreshLiplis()
    {
        //キャンセルフェーズ
        if checkMsg(){return}
        
        //おすわりチェック
        if checkSitdown(){return}
        
        //タグチェック ひとまず保留
        //if checkTag(){}
        
        //スキップチェック
        if checkSkip()
        {
            updateText()
        }
        
        //ナウワード取得、ナウテキスト設定
        if(setText()){return}
        
        //テキストの設定
        updateText()
        
        //ボディの更新
        updateBody()
    }
    
    /*
        瞬時リフレッシュ
    */
    func immediateRefresh()
    {
        //キャンセルフェーズ
        if checkMsg(){return}
        
        //スキップ
        skipLiplis()
        
        //テキストの設定
        updateText()
        
        //ボディの更新
        updateBody()
        
        //終了
        checkEnd()
    }
    
    func updateBatteryInfo()
    {
        
    }
    
    /*
        メッセージチェック
    */
    func checkMsg()->Bool
    {
        if liplisNowTopic == nil
        {
            reSetUpdateCount()
            return true
        }
        return false
    }
    
    /*
        スキップチェック
    */
    func checkSkip()->Bool
    {
        var result : Bool = false
        
        if flgSkip{
            flgSkipping = true
            chatStop()
            result = skipLiplis()
            flgSkipping = false
        }
        return result
    }
    
    /*
        スキップ
    */
    func skipLiplis()->Bool
    {
        liplisChatText = ""
        
        if liplisNowTopic != nil
        {
            for var idx = 0, n = liplisNowTopic.nameList.count; idx<n; idx++
            {
                if idx != 0
                {
                    //ナウワードの初期化
                    liplisNowWord = liplisNowTopic.nameList[idx]
                    
                    //プレブエモーションセット
                    prvEmotion = nowEmotion
                    
                    //なうエモーションの取得
                    nowEmotion = liplisNowTopic.emotionList[idx]
                    
                    //なうポイントの取得
                    nowPoint = liplisNowTopic.pointList[0]
                }
                //初回ワードチェック
                else if(idx == 0)
                {
                    liplisNowWord = liplisNowTopic.nameList[idx]
                    
                    //空だったら、空じゃなくなるまで繰り返す
                    if(liplisNowWord != "")
                    {
                        do
                        {
                            //次ワード遷移
                            idx++
                            
                            //終了チェック
                            if(liplisNowTopic.nameList.count < idx)
                            {
                                if(idx > liplisNowTopic.nameList[idx].utf16Count){break}
                                
                                //ナウワードの初期化
                                liplisNowWord = liplisNowTopic.nameList[idx]
                            }
                        }
                        while(liplisNowWord == "")
                    }
                }
                //おしゃべり中は何もしない
                else
                {
                    
                }
                
                for(var kdx : Int = 0, n = liplisNowWord.utf16Count; kdx<n; kdx++)
                {
                    
                    liplisChatText = liplisChatText + (liplisNowWord as NSString).substringWithRange(NSRange(location : kdx,length : 1))
                }
                
                cntLnw = liplisNowTopic.nameList.count
                cntLct = liplisNowWord.utf16Count
            }
            return true
        }
        else
        {
            return false
        }
    }
    
    /*
        座りチェック
    */
    func checkSitdown()->Bool
    {
        if flgSitdown
        {
            liplisNowTopic = nil
            updateBodySitDown()
            return true
        }
        return false
    }
    
    /*
        終了チェック
    */
    func checkEnd()->Bool
    {
        if(cntLnw>=liplisNowTopic.nameList.count)
        {
            desk.lpsLog.append(liplisChatText, url: liplisNowTopic.url)
            chatStop()
            herfEyeCheck()
            liplisNowTopic = nil
            return true
        }
        return false
    }
    
    /*
        テキストの更新
    */
    func setText()->Bool
    {
        //送りワード文字数チェック
        if(cntLnw != 0)
        {
            if(cntLct >= liplisNowWord.utf16Count)
            {
                //終了チェック
                if(checkEnd()){return true}
                
                //チャットテキストカウントの初期化
                cntLct = 0
                
                //なうワードの初期化
                liplisNowWord = liplisNowTopic.nameList[cntLnw]
                
                //プレブエモーションセット
                prvEmotion = nowEmotion
                
                //なうエモーションの取得
                nowEmotion = liplisNowTopic.emotionList[cntLnw]
                
                //なうポイントの取得
                nowPoint = liplisNowTopic.pointList[cntLnw]
                
                //インデックスインクリメント
                cntLnw = cntLnw + 1
            }
        }
        else if(cntLnw == 0)
        {
            //チャットテキストカウントの初期化
            cntLct = 0
            
            //空チェック
            if liplisNowTopic.nameList.count == 0
            {
                checkEnd()
                return true
            }
            
            //なうワードの初期化
            liplisNowWord = liplisNowTopic.nameList[cntLnw]

            //次ワード遷移
            cntLnw = cntLnw + 1
            
            //空だったら、空じゃなくなるまで繰り返す
            if(liplisNowWord == "")
            {
                do
                {
                    //チェックエンド
                    checkEnd()
                    
                    //終了チェック
                    if(cntLnw>liplisNowTopic.nameList[cntLnw].utf16Count){break}
                    
                    //ナウワードの初期化
                    liplisNowWord = liplisNowTopic.nameList[cntLnw]

                    //次ワード遷移
                    cntLnw = cntLnw + 1
                }
                while(liplisNowWord == "")
            }
        }
        else
        {
            
        }
        //おしゃべり
        liplisChatText = liplisChatText + (liplisNowWord as NSString).substringWithRange(NSRange(location : cntLct,length : 1))
        cntLct = cntLct + 1
        
        return false
    }
    
    /*
        テキストビューの更新
    */
    func updateText()
    {
        lblLpsTalkLabel.text = liplisChatText
    }
    
    /*
        ボディの更新
    */
    func updateBody()->Bool
    {
        //感情変化セット
        setObjectBody()
        
        //口パクカウント
        if(flgChatting)
        {
            if(cntMouth == 1){cntMouth = 2}
            else             {cntMouth = 1}
        }
        else
        {
            cntMouth = 1
        }
        
        //めぱちカウント
        if(cntBlink == 0){cntBlink = getBlincCnt()}
        else             {cntBlink = cntBlink - 1}
        
        autoreleasepool { () -> () in
            self.imgBody.image = nil
            //self.imgBody.image = self.ob.getLiplisBodyImgId(self.getBlinkState(),mouthState: self.cntMouth)
            self.imgBody.image = self.ob.getLiplisBodyImgIdIns(self.getBlinkState(),mouthState: self.cntMouth)
            self.imgBody.setNeedsDisplay()
        }
       
        
        return true
    }

    /*
    ボディの更新
    */
    func updateBodySitDown()
    {
        self.imgBody.image = nil
        self.imgBody.image = lpsBody.sleep
    }
    
    
    
    
    
    //============================================================
    //
    //ボディ制御
    //
    //============================================================
    
    /*
        ボディの取得
    */
    func setObjectBody()->Bool
    {
        if(nowEmotion != prvEmotion && flgChatting)
        {
            //バッテリーレベルによる容姿変化の処理はここに入れる
            
            //現在の感情値、感情レベルからボディを一つ取得
            ob = lpsBody.getLiplisBody(nowEmotion, point: nowPoint)
            
            return true
        }
        
        return false
    }
    
    /*
        ボディを初期状態に戻す
    */
    func setObjectBodyNeutral()->Bool
    {
        cntMouth = 1
        cntBlink = 0
        nowEmotion = 0
        nowPoint = 0
        
        if os.lpsHealth == 1 && lpsBattery.batteryNowLevel > 75
        {
            //ヘルス設定ONでバッテリー残量が７５％以下なら小破以下の画像取得
            ob = lpsBody.getLiplisBodyHelth(Int(lpsBattery.batteryNowLevel), emotion: nowEmotion, point: nowPoint)
        }
        else
        {
            ob = lpsBody.getLiplisBody(nowEmotion, point : nowPoint)
        }
        
        //reqReflesh()
        
        return true
    }
    
    
    /*
        まばたきカウント
    */
    func getBlincCnt()->Int{
        return LiplisUtil.getRandormNumber(Min: 30,Max: 50)
    }
    
    /*
        まばたき状態の取得
    */
    func getBlinkState()->Int
    {
        switch(cntBlink)
        {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 3
        case 3:
            return 2
        default:
            return 1
        }
    }
    
    /*
        半目チェック
    */
    func herfEyeCheck()
    {
        if(cntBlink == 1 || cntBlink == 3)
        {
            cntBlink = 0
            updateBody()
        }
    }
    
    //============================================================
    //
    //チャット制御
    //
    //============================================================
    
    /*
        チャットスタート
    */
    func chatStart()
    {
        flgChatting = true
        
        //瞬時表示チェック
        if os.lpsSpeed == 3
        {
            immediateRefresh()
        }
        else
        {
            //実行モードを12に設定する
            flgAlarm = 12
            
            //更新タイマーをONする
            startUpdateTimer()
        }
    }
    
    /*
        チャットストップ
    */
    func chatStop()
    {
        flgAlarm = 0
        
        reSetUpdateCount()
        
        flgChatting = false
        flgSkip = false
    }
    
    
    //============================================================
    //
    //話題管理
    //
    //============================================================
    
    /*
        1件のトピックを取得する
    */
    func getTopic()
    {
        flgChatTalk = false
        flgThinking = true
        
        getShortNews()
        
        flgThinking = false
    }
    
    
    
    /*
        ニュースキューチェック
    */
    func onCheckNewsQueue()
    {
        if(!flgSitdown)
        {
            lpsNews.checkNewsQueue(getPostDataForLiplisNewsList())
        }
    }
    
    /*
        ニュースを取得する
    */
    func getShortNews()
    {
        liplisNowTopic = lpsNews.getShortNews(getPostDataForLiplisNews())
        
        //取得失敗メッセージ
        if liplisNowTopic == nil
        {
            liplisNowTopic = FctLiplisMsg.createMsgMassageDlFaild()
            liplisUrl = ""
        }
        else
        {
            liplisUrl = liplisNowTopic.url
        }
        
    }
    
    /*
        ポストパラメーターの作成(ニュース単体向け)
    */
    func getPostDataForLiplisNews()->NSData
    {
        var nameValuePair : NameValuePair = NameValuePair()
        nameValuePair.add(BasicNameValuePair(key: "tone", value: lpsSkin.tone))
        nameValuePair.add(BasicNameValuePair(key: "newsFlg", value: os.getNewsFlg()))
        nameValuePair.add(BasicNameValuePair(key: "randomkey", value: LiplisDate().getTimeStr()))   //キャッシュ防止
        return nameValuePair.getPostData()
    }
    
    /*
        ポストパラメーターの作成(ニュースリスト向け)
    */
    func getPostDataForLiplisNewsList()->NSData
    {
        var nameValuePair : NameValuePair = NameValuePair()
        nameValuePair.add(BasicNameValuePair(key: "userid", value: desk.baseSetting.lpsUid))
        nameValuePair.add(BasicNameValuePair(key : "tone", value: lpsSkin.tone))
        nameValuePair.add(BasicNameValuePair(key: "newsFlg", value: os.getNewsFlg()))
        nameValuePair.add(BasicNameValuePair(key : "num", value: "20"))
        nameValuePair.add(BasicNameValuePair(key: "hour", value: os.getLpsNewsRangeStr()))
        nameValuePair.add(BasicNameValuePair(key: "already", value: String(os.lpsNewsAlready)))
        nameValuePair.add(BasicNameValuePair(key: "twitterMode", value: String(os.lpsTopicTwitterMode)))
        nameValuePair.add(BasicNameValuePair(key: "runout", value: String(os.lpsNewsRunOut)))
        nameValuePair.add(BasicNameValuePair(key: "randomkey", value: LiplisDate().getTimeStr()))   //キャッシュ防止
        
        return nameValuePair.getPostData()
    }

    //============================================================
    //
    //状態制御
    //
    //============================================================
    
    /*
    おはよう
    */
    func wakeup()
    {
        //おやすみ状態の場合、ウェイクアップ
        flgSitdown = false
        
        icoSleep.setImage(lpsIcon.imgSleep,forState : UIControlState.Normal)
        
        greet()
    }
    
    /*
    おやすみ
    */
    func sleep()
        {
        //ウェイクアップ状態の場合、おやすみ
        flgSitdown = true
        
        icoSleep.setImage(lpsIcon.imgWakeup,forState : UIControlState.Normal)
        lblLpsTalkLabel.text = "zzz"
        
        updateBodySitDown()
    }
    
    /*
    アイコン表示
    */
    func iconOn()
    {
        icoSleep.hidden = false
        icoLog.hidden = false
        icoSetting.hidden = false
        icoChat.hidden = false
        icoClock.hidden = false
        icoBattery.hidden = false
    }
    
    /*
    アイコン非表示
    */
    func iconOff()
    {
        icoSleep.hidden = true
        icoLog.hidden = true
        icoSetting.hidden = true
        icoChat.hidden = true
        icoClock.hidden = true
        icoBattery.hidden = true
    }
    
    /*
    最前面に移動する
    */
    func goToTheFront()
    {
        self.desk.view.bringSubviewToFront(self.imgWindow)
        self.desk.view.bringSubviewToFront(self.lblLpsTalkLabel)
        self.desk.view.bringSubviewToFront(self.imgBody)
        self.desk.view.bringSubviewToFront(self.icoSleep)
        self.desk.view.bringSubviewToFront(self.icoLog)
        self.desk.view.bringSubviewToFront(self.icoSetting)
        self.desk.view.bringSubviewToFront(self.icoChat)
        self.desk.view.bringSubviewToFront(self.icoClock)
        self.desk.view.bringSubviewToFront(self.icoBattery)
        
        
        self.desk.view.bringSubviewToFront(self.imgClockBase)
        self.desk.view.bringSubviewToFront(self.imgClockLongHand)
        self.desk.view.bringSubviewToFront(self.imgClockShortHand)
    }
    
    //============================================================
    //
    //ほか画面呼び出し
    //
    //============================================================
    
    /*
   　ウィジェット設定画面を呼び出す
    */
    func callWidgetSetting()
    {
        let modalView : ViewWidgetMenu = ViewWidgetMenu(widget: self)
        modalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        desk.presentViewController(modalView, animated: true, completion: nil)
    }
    
    /*
    チャット画面を呼び出す
    */
    func callChat()
    {
        let modalView : ViewChat = ViewChat(widget : self)
        modalView.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        modalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            
        desk.presentViewController(modalView, animated: true, completion: nil)
    }
}