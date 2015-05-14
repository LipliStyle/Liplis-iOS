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
    internal var liplisInterval : Int! = 100;		//インターバル
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
    internal init(desk:ViewDeskTop!, os : ObjPreference, lpsSkinData : LiplisSkinData!)
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
    internal func initView()
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
        
        //時計設定
        self.setClock()
    }
    
    /*
    XML読み込み
    オーバーライドが必要
    */
    internal func initXml()
    {
        //ボディインスタンス
        self.lpsSkin = self.lpsSkinData.lpsSkin
        self.lpsChat = ObjLiplisChat(url:self.lpsSkinData.xmlChat)
        self.lpsBody = ObjLiplisBody(url:self.lpsSkinData.xmlBody, bodyPath: self.lpsSkinData.pathBody)
        self.lpsTouch = ObjLiplisTouch(url:self.lpsSkinData.xmlTouch)
        self.lpsVer = ObjLiplisVersion(url:self.lpsSkinData.xmlVersion)
        self.lpsIcon = ObjLiplisIcon(windowPath: self.lpsSkinData.pathWindow)
    }
    
    /*
    クラスの初期化
    */
    internal func initClass()
    {
        //デフォルトボディロード
        self.ob = lpsBody.getDefaultBody()
        
        //ニュースの初期化
        self.lpsNews = LiplisNews()
        
        //話題収集の実行
        self.onCheckNewsQueue()
        
        //バッテリーオブジェクトの初期化
        self.lpsBattery = ObjBattery()
            
        //チャットAPIインスタンス
        self.lpsChatTalk = LiplisApiChat()
    }

    /*
        チャット情報の初期化
    */
    internal func initChatInfo()
    {
        //チャットテキストの初期化
        self.liplisChatText = ""
        
        //なうワードの初期化
        self.liplisNowWord = ""
        
        //ナウ文字インデックスの初期化
        self.cntLct = 0
        
        //ナウワードインデックスの初期化
        self.cntLnw = 0
    }
    
    /*
    ウインドウのセット
    オーバーライドが必要
    */
    internal func setWindow()
    {
        //スキンのウインドウファイルにアクセス
        self.imgWindow.image = UIImage(contentsOfFile: self.lpsSkinData.pathWindow + "/" + os.lpsWindowColor)
    }
    
    /*
    時計のセット
    */
    internal func setClock()
    {
        //現在日時取得
        let date : LiplisDate = LiplisDate()
        
        //時計イメージ取得
        self.imgClockLongHand.image = self.desk.imgClockLongHand
        self.imgClockShortHand.image = self.desk.imgClockShortHand
        
        //現在分の計算
        let dblkeikaMin : Double = Double(60 * date.hour! + date.minute!)
        let dblMin : Double = Double(date.minute!)
        
        //角度の計算
        let argHour = CGFloat((2 * M_PI * dblkeikaMin) / (60 * 12))
        let argMin = CGFloat((2 * M_PI * dblMin)/60)
        
        //時計セット
        self.imgClockShortHand.transform = CGAffineTransformMakeRotation(argHour)
        self.imgClockLongHand.transform = CGAffineTransformMakeRotation(argMin)
        
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
    internal func dispose()
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
    internal func startUpdateTimer()
    {
        //すでに動作中なら破棄しておく
        self.stopUpdateTimer()
        
        //タイマースタート
        self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
    }
    internal func stopUpdateTimer()
    {
        //すでに起動していたら破棄する
        if self.updateTimer != nil && self.updateTimer.valid
        {
            self.updateTimer.invalidate()
        }
    }
    
    /*
    ネクストタイマースタート
    */
    internal func startNextTimer(pInterval : Double)
    {
        //すでに動作中なら破棄しておく
        self.stopNextTimer()
        
        //タイマースタート
        self.nextTimer = NSTimer.scheduledTimerWithTimeInterval(pInterval, target: self, selector : "onNext:", userInfo: nil, repeats: true)
    }
    internal func stopNextTimer()
    {
        //すでに起動していたら破棄する
        if self.nextTimer != nil && self.nextTimer.valid
        {
            self.nextTimer.invalidate()
        }
    }
    /*
    ドラッグ移動開始タイマー
    */
    internal func startStartMoveTimer()
    {
        //すでに動作中なら破棄しておく
        self.stopStartMoveTimer()
        
        //タイマースタート
        self.startMoveTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector : "onstartMove:", userInfo: nil, repeats: true)
    }
    internal func stopStartMoveTimer()
    {
        //すでに起動していたら破棄する
        if self.startMoveTimer != nil && self.startMoveTimer.valid
        {
            self.startMoveTimer.invalidate()
        }
    }
    
    /*
        おしゃべりタイマー
        10秒間隔で実行
        おしゃべり中は停止する
    */
    internal func onNext(timer : NSTimer)
    {
        //アイコン表示オフなら、アイコンを消去する
        if self.os.lpsDisplayIcon == 0
        {
            self.iconOff()
        }
        
        //次の話題
        self.nextLiplis()
    }
    
    
    /*
        おしゃべりタイマー
        0.1間隔で実行
    */
    internal func onUpdate(timer : NSTimer)
    {
        //おしゃべり中なら、Liplisアップデート
        if(self.flgAlarm == 12)
        {
            self.updateLiplis()
        }
    }
    
    
    /*
        アップデートカウントのリセット
    */
    func reSetUpdateCount()
    {
        //無口の場合はタイマーを更新しない
        if self.os.lpsMode == 3
        {
            //すでに動作中なら破棄しておく
            self.stopNextTimer()
            return
        }
        
        //チャットトーク時は、60秒のインターバルを設定
        if !self.flgChatTalk
        {
            self.startNextTimer(self.os.lpsInterval)
        }
        else
        {
            self.startNextTimer(60.0)
        }
    }
    
    /*
    ドラッグ移動開始タイマー
    タップしてから３秒後に実行
    */
    internal func onstartMove(timer : NSTimer)
    {
        //移動可能にする
        self.startMove()
        
        //移動開始タイマーを破棄
        self.stopStartMoveTimer()
    }
    
    
    //============================================================
    //
    //イベントハンドラ
    //
    //============================================================
    
    /*
        タッチ開始イベント
    */
    internal func touchesBegan(touches: NSSet)->Bool {
        //フレーム取得
        var frameImgBody: CGRect = self.imgBody.frame
        
        // タッチイベントを取得.
        let aTouch = touches.anyObject() as UITouch
        
        // タッチ位置の取得
        let location = aTouch.locationInView(self.imgBody)

        //範囲チェック
        if((location.x >= 0 && location.x <= frameImgBody.width) && (location.y >= 0 && location.y <= frameImgBody.height))
        {
            //アニメーション
            UIView.animateWithDuration(0.06,
                // アニメーション中の処理(縮小)
                animations: { () -> Void in
                    self.imgBody.transform = CGAffineTransformMakeScale(0.9, 0.9)
                })
            { (Bool) -> Void in}
            
            //移動制御タイマー開始
            self.startStartMoveTimer()
            
            return true
        }
        
        //ウインドウフレーム取得
        var frameImgWindow : CGRect = imgWindow.frame
        
        //ウインドウクリックモードチェック
        //down時はアニメーションのみ
        if(self.desk.baseSetting.lpsTalkWindowClickMode == 1)
        {
            //ウインドウタッチ位置の取得
            let locationWindow = aTouch.locationInView(imgWindow)
            
            //ウインドウタッチ位置チェック
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
    internal func touchesMoved(touches: NSSet)->Bool  {
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
                //移動する前の座標を取得.
                let prevLocation = aTouch.previousLocationInView(imgBody)
                
                //移動量計算
                let deltaX: CGFloat = location.x - prevLocation.x
                let deltaY: CGFloat = location.y - prevLocation.y
                
                // 移動した分の距離をmyFrameの座標にプラスする.
                self.imgBody.frame.origin.x += deltaX
                self.imgBody.frame.origin.y += deltaY

                //ほかパーツの追随
                self.setWidgetLocation(0,windowOffsetY : 0)
         
                return true
            }
        }

        return false
    }
    
    /*
        タッチ終了イベント
    */
    internal func touchesEnded(touches: NSSet)->Bool  {
        //フレーム取得
        var frameImgBody : CGRect = imgBody.frame
            
        //タッチイベントを取得.
        let aTouch = touches.anyObject() as UITouch
            
        //タッチ位置取得
        let location = aTouch.locationInView(imgBody)
        
        //タッチ範囲チェック
        if(location.x >= 0 && location.x <= frameImgBody.width) && (location.y >= 0 && location.y <= frameImgBody.height)
        {
            //タッチ位置保存
            self.saveLocation()
            
            //アニメーション.
            UIView.animateWithDuration(0.1,
            // アニメーション中の処理(縮小して拡大)
            animations: { () -> Void in
                self.imgBody.transform = CGAffineTransformMakeScale(0.4, 0.4)
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
            self.desk.flgMoving = false
            
            //移動制御タイマーを破棄しておく
            self.stopStartMoveTimer()
            
            return true
        }
        
        //ウインドウフレーム取得
        var frameImgWindow : CGRect = imgWindow.frame
        
        //ウインドウクリック設定が有効なら、ウインドウ範囲チェックを行う
        if(self.desk.baseSetting.lpsTalkWindowClickMode == 1)
        {
            //タッチ位置の表示
            let locationWindow = aTouch.locationInView(imgWindow)
            
            //ウインドウ範囲チェック
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
    
    /*
    各パーツをボディに追随させる
    */
    internal func setWidgetLocation(offsetY : CGFloat, windowOffsetY : CGFloat)
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
        
        //移動したフレーム値を反映
        self.imgWindow.frame = frameImgWindow
        self.lblLpsTalkLabel.frame = frameLblTalkLabel
        
        self.imgClockBase.frame = frameIcoClock
        self.imgClockLongHand.frame = frameIcoClock
        self.imgClockShortHand.frame = frameIcoClock
        
        self.icoSleep.frame = frameIcoSleep
        self.icoLog.frame = frameIcoLog
        self.icoSetting.frame = frameIcoSetting
        self.icoChat.frame = frameIcoChat
        self.icoClock.frame = frameIcoClock
        self.icoBattery.frame = frameIcoBattery
        
        //レクトの設定
        self.frame = CGRect(x: frameImgWindow.origin.x, y: frameImgWindow.origin.y, width: frameImgWindow.width, height: frameIcoSetting.origin.y + frameIcoSetting.height - frameImgWindow.origin.y)
    }
    
    /*
    移動開始処理
    */
    internal func startMove()
    {
        //アニメーション
        UIView.animateWithDuration(0.06,
        animations: { () -> Void in
            self.imgBody.transform = CGAffineTransformMakeScale(0.4, 0.4)
            self.imgBody.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.imgBody.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
        
        //ウィジェットを最前面に移動する
        self.goToTheFront()
        
        //移動開始
        self.self.desk.flgMoving = true
        desk.onDragTrashBegin()
    }
    
    /*
        ボディクリック時処理
    */
    internal func onClickBody()
    {
        //チャット中チェック
        if(!self.flgChatting)
        {
            //チャット中でなければ、次の話題おしゃべり
            self.nextLiplis()
        }
        else
        {
            //チャット中ならスキップする
            self.flgSkip = true
        }
        
        //アイコンを有効にする
        self.iconOn()
        
        //時計合わせ
        self.setClock()
    }
    
    /*
    ウインドウクリック時処理
    */
    internal func onClickWindow()
    {
        if(self.liplisUrl != "")
        {
            if self.desk.baseSetting.lpsBrowserMode == 0
            {
                //URL設定
                self.desk.app.activityWeb.url = NSURL(string: self.liplisUrl)!
                
                //タブ移動
                self.desk.tabBarController?.selectedIndex=4
            }
            else  if self.desk.baseSetting.lpsBrowserMode == 1
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
    internal func onClickSleep()
    {
        //おやすみチェック
        if self.flgSitdown
        {
            //おやすみ中なら、起こす
            self.wakeup()
        }
        else
        {
            //通常なら、おやすみ
            self.sleep()
        }
    }
    
    /*
    ウィジェットをデスクトップ内に復帰させる
    */
    internal func rescue(offset : Int)
    {
        //X軸範囲チェック
        if self.frame.origin.x < CGFloat(offset * -1)   //-40
        {
            self.imgBody.frame.origin.x = 10 + (self.imgWindow.frame.width/2 - self.imgBody.frame.width/2)
        }
        else if self.frame.origin.x >= self.desk.view.frame.width - self.frame.width + CGFloat(offset) //40
        {
            self.imgBody.frame.origin.x = self.desk.view.frame.width - self.frame.width + (self.imgWindow.frame.width/2 - self.imgBody.frame.width/2) - 10
        }
        
        //Y軸範囲チェック
        if self.frame.origin.y < CGFloat(offset * -1)   //-40
        {
            self.imgBody.frame.origin.y = 50
        }
        else if self.frame.origin.y > self.desk.view.frame.height - self.frame.height + CGFloat(offset/2) //20
        {
            self.imgBody.frame.origin.y = self.desk.view.frame.height - self.frame.height - 80
        }

        //パーツの位置調整
        self.setWidgetLocation(-10, windowOffsetY: 5)
        
        //座標セーブ
        self.saveLocation()
    }

    /*
    座標をセーブルする
    */
    internal func saveLocation()
    {
        self.os.locationX = Int(self.imgBody.layer.position.x)
        self.os.locationY = Int(self.imgBody.layer.position.y)
        self.os.saveSetting()
    }
    
    
    //============================================================
    //
    //ボタンイベント
    //
    //============================================================
    
    /*
    スリープボタンイベント
    */
    internal func onDownIcoSleep(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
            self.icoSleep.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
        onClickSleep()
    }
    internal func onUpIcoSleep(sender: UIButton){
        UIView.animateWithDuration(0.1,animations: { () -> Void in
        self.icoSleep.transform = CGAffineTransformMakeScale(0.4, 0.4)
        self.icoSleep.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
    }
    
    /*
    ログボタンイベント
    */
    internal func onDownIcoLog(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
        self.icoLog.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
    }
    internal func onUpIcoLog(sender: UIButton){
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
    internal func onDownIcoSetting(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
        self.icoSetting.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
    }
    internal func onUpIcoSetting(sender: UIButton){
        UIView.animateWithDuration(0.1,animations: { () -> Void in
        self.icoSetting.transform = CGAffineTransformMakeScale(0.4, 0.4)
        self.icoSetting.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
        //ウィジェット設定メニュー呼び出し
        self.callWidgetSetting()
    }
    
    /*
    チャットボタンイベント
    */
    internal func onDownIcoChat(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
        self.icoChat.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
    }
    internal func onUpIcoChat(sender: UIButton){
        UIView.animateWithDuration(0.1,animations: { () -> Void in
        self.icoChat.transform = CGAffineTransformMakeScale(0.4, 0.4)
        self.icoChat.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
        
        //おしゃべり画面呼び出し
        self.callChat()
    }

    /*
    クロックボタンイベント
    */
    internal func onDownIoClock(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
        self.icoClock.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
        
        //時刻おしゃべり
        self.clockInfo()
    }
    internal func onUpIoClock(sender: UIButton){
        UIView.animateWithDuration(0.1,animations: { () -> Void in
        self.icoClock.transform = CGAffineTransformMakeScale(0.4, 0.4)
        self.icoClock.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
        
    }
    
    /*
    バッテリーボタンイベント
    */
    internal func onDownIcoBattery(sender: UIButton){
        UIView.animateWithDuration(0.06,animations: { () -> Void in
        self.icoBattery.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
        
        //バッテリー情報おしゃべり
        self.batteryInfo()
    }
    internal func onUpIcoBattery(sender: UIButton){
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
    internal func greet()
    {
        self.liplisNowTopic = self.lpsChat.getGreet()
        
        if self.liplisNowTopic.getMessage() == ""
        {
            self.liplisNowTopic = MsgShortNews(name: "なうろーでぃんぐ♪",emotion: 0,point: 0)
        }
        
        //チャット情報の初期化
        self.initChatInfo()
        
        //チャットスタート
        self.chatStart()
    }
    
    /*
        バッテリー情報おしゃべり
    */
    internal func batteryInfo()
    {
        //座り中なら回避
        if(self.flgSitdown){return}
        
        //挨拶の選定
        self.liplisNowTopic = self.lpsChat.getBatteryInfo(Int(self.lpsBattery.batteryNowLevel * 100))
           
        //チャット情報の初期化
        self.initChatInfo()
                
        //チャットスタート
        self.chatStart()
    }
    
    /*
    時刻情報おしゃべり
    */
    internal func clockInfo()
        {
        //座り中なら回避
        if(self.flgSitdown){return}
        
        //挨拶の選定
        self.liplisNowTopic = self.lpsChat.getClockInfo()
            
        //チャット情報の初期化
        self.initChatInfo()
            
        //チャットスタート
        self.chatStart()
    }
    
    /*
        時報チェック
    */
    internal func onTimeSignal()->Bool
    {
        var result : Bool = false
        
        //現在時間取得
        var nowHour : Int = self.getHour()
        
        if(nowHour != self.prvHour)
        {
            //座り中なら回避
            if(self.flgSitdown){return false}
            
            //時報取得
            self.liplisNowTopic = self.lpsChat.getTimeSignal(nowHour)
            
            //時報データが無い場合は時報をおしゃべりしない
            if self.liplisNowTopic == nil
            {
                self.prvHour = self.getHour()
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
    internal func getHour()->Int{
        var date : LiplisDate = LiplisDate()
        return date.hour!
    }
    
    /*
    話しかけ取得
    */
    internal func chatTalkRecive(chatText : String)
    {
        //座り中なら回避
        if(self.flgSitdown){return}
        
        //挨拶の選定
        self.liplisNowTopic = lpsChatTalk.apiPost(self.desk.baseSetting.lpsUid, toneUrl: self.lpsSkin.tone,version: "I" + LiplisUtil.getAppVersion(),sentence: chatText)
            
        //チャット情報の初期化
        self.initChatInfo()
        
        //チャットスタート
        self.chatStart()
    }
    
    
    //============================================================
    //
    //おしゃべり準備処理
    //
    //============================================================
    /*
        チャット情報の初期化
    */
    internal func initchatInfo()
    {
        //チャットテキストの初期化
        self.liplisChatText = ""
        
        //ナウワードの初期化
        self.liplisNowWord = ""
        
        //ナウ文字インデックスの初期化
        self.cntLct = 0
        
        //なうワードインデックスの初期化
        self.cntLnw = 0
    }
    
    /*
        話題残量チェック
    */
    internal func checkRunout()->Bool
    {
        return (self.os.lpsNewsRunOut == 1) && self.lpsNews.checkNewsQueueCount(self.getPostDataForLiplisNewsList())
    }
    
    //============================================================
    //
    //おしゃべり処理
    //
    //============================================================

    /*
        次の話題
    */
    internal func nextLiplis()
    {
        self.flgAlarm = 0
        
        //バッテリーチェック
        self.icoBattery.setImage(self.lpsIcon.getBatteryIcon(self.lpsBattery.getBatteryRatel()),  forState: UIControlState.Normal)
        
        //おすわりチェック
        if(self.flgSitdown){
            self.stopNextTimer()
            self.stopUpdateTimer()
            return
        }
        
        //URLの初期化
        self.liplisUrl = ""
        
        //モードチェック
        if(self.os.lpsMode == 0 || self.os.lpsMode == 1 || self.os.lpsMode == 2)
        {
            //時報チェック
            if(self.onTimeSignal())
            {
                return
            }
            
            //話題がつきたかチェック
            if(self.checkRunout())
            {
                //再カウント
                reSetUpdateCount()
                return
            }
            
            //次の話題おしゃべり
            self.runLiplis()
        }
        else if(self.os.lpsMode == 3)
        {
            self.runLiplis()
        }
        else if(self.os.lpsMode == 4)
        {
            //時計＆バッテリー(ios版ではなし)
        }
    }
    
    /*
    次の話題スタート
    */
    internal func runLiplis()
    {
        //チャット中なら終了する
        if(self.flgChatting){self.chatStop();return}
        
        //座り中なら回避
        if(self.flgSitdown){self.chatStop();return}
        
        //ウインドウチェック ウインドウが消える仕様は保留する
        //windowsOn()
        
        //クロックチェック
        //ios版では時計表示なし
        
        //アイコンカウント
        //iconCloseCheck()
        
        //立ち絵をデフォルトに戻す
        self.setObjectBodyNeutral()
        
        //トピックを取得する
        self.getTopic()
        
        //チャット情報の初期化
        self.initChatInfo()
        
        //チャットスタート
        self.chatStart()
    }
    
    
    /*
        リプリスの更新
    */
    internal func updateLiplis()
    {
        //設定速度に応じて動作をウェイトさせる
        switch(self.os.lpsSpeed)
        {
        case 0 :    //最速　常に実行
            if(self.flgAlarm != 0){self.refreshLiplis()}
            break
            
        case 1 :    //普通　１回休む
            if(self.cntSlow >= 1)
            {
                self.refreshLiplis()
                self.cntSlow = 0
            }
            else
            {
                self.cntSlow = self.cntSlow + 1
            }
            break
        case 2 :    //おそい　２回休む
            if(self.cntSlow >= 2)
            {
                refreshLiplis()
                self.cntSlow = 0
            }
            else
            {
                self.cntSlow = self.cntSlow + 1
            }
            break
        case 3 :    //瞬間表示
            self.immediateRefresh()
            break
        default :   //ほかの値が設定された場合は瞬間表示とする
            self.immediateRefresh()
            break
        }
    }
    
    /*
        リフレッシュ
    */
    internal func refreshLiplis()
    {
        //キャンセルフェーズ
        if self.checkMsg(){return}
        
        //おすわりチェック
        if self.checkSitdown(){return}
        
        //タグチェック ひとまず保留
        //if checkTag(){}
        
        //スキップチェック
        if self.checkSkip()
        {
            self.updateText()
        }
        
        //ナウワード取得、ナウテキスト設定
        if(self.setText()){return}
        
        //テキストの設定
        self.updateText()
        
        //ボディの更新
        self.updateBody()
    }
    
    /*
        瞬時リフレッシュ
    */
    internal func immediateRefresh()
    {
        //キャンセルフェーズ
        if self.checkMsg(){return}
        
        //スキップ
        self.skipLiplis()
        
        //テキストの設定
        self.updateText()
        
        //ボディの更新
        self.updateBody()
        
        //終了
        self.checkEnd()
    }
    
    /*
        メッセージチェック
    */
    internal func checkMsg()->Bool
    {
        //現在の話題が破棄されていれば、アップデートカウントをリセットする
        if self.liplisNowTopic == nil
        {
            self.reSetUpdateCount()
            return true
        }
        return false
    }
    
    /*
        スキップチェック
    */
    internal func checkSkip()->Bool
    {
        var result : Bool = false
        
        //スキップチェック
        if self.flgSkip{
            //スキップ処理中有効
            self.flgSkipping = true
            
            //チャット停止
            self.chatStop()
            
            //スキップ処理
            result = self.skipLiplis()
            
            //スキップ処理中終了
            self.flgSkipping = false
        }
        return result
    }
    
    /*
        スキップ
    */
    internal func skipLiplis()->Bool
    {
        self.liplisChatText = ""
        
        if self.liplisNowTopic != nil
        {
            for var idx = 0, n = self.liplisNowTopic.nameList.count; idx<n; idx++
            {
                if idx != 0
                {
                    //ナウワードの初期化
                    self.liplisNowWord = self.liplisNowTopic.nameList[idx]
                    
                    //プレブエモーションセット
                    self.prvEmotion = self.nowEmotion
                    
                    //なうエモーションの取得
                    self.nowEmotion = self.liplisNowTopic.emotionList[idx]
                    
                    //なうポイントの取得
                    self.nowPoint = self.liplisNowTopic.pointList[0]
                }
                //初回ワードチェック
                else if(idx == 0)
                {
                    self.liplisNowWord = self.liplisNowTopic.nameList[idx]
                    
                    //空だったら、空じゃなくなるまで繰り返す
                    if(self.liplisNowWord != "")
                    {
                        do
                        {
                            //次ワード遷移
                            idx++
                            
                            //終了チェック
                            if(self.liplisNowTopic.nameList.count < idx)
                            {
                                if(idx > self.liplisNowTopic.nameList[idx].utf16Count){break}
                                
                                //ナウワードの初期化
                                self.liplisNowWord = self.liplisNowTopic.nameList[idx]
                            }
                        }
                        while(self.liplisNowWord == "")
                    }
                }
                //おしゃべり中は何もしない
                else
                {
                    
                }
                
                for(var kdx : Int = 0, n = self.liplisNowWord.utf16Count; kdx<n; kdx++)
                {
                    self.liplisChatText = self.liplisChatText + (self.liplisNowWord as NSString).substringWithRange(NSRange(location : kdx,length : 1))
                }
                
                self.cntLnw = self.liplisNowTopic.nameList.count
                self.cntLct = self.liplisNowWord.utf16Count
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
    internal func checkSitdown()->Bool
    {
        if self.flgSitdown
        {
            self.liplisNowTopic = nil
            self.updateBodySitDown()
            return true
        }
        return false
    }
    
    /*
        終了チェック
    */
    internal func checkEnd()->Bool
    {
        if(self.cntLnw>=self.liplisNowTopic.nameList.count)
        {
            self.desk.lpsLog.append(self.liplisChatText, url: self.liplisNowTopic.url)
            self.chatStop()
            self.herfEyeCheck()
            self.liplisNowTopic = nil
            return true
        }
        return false
    }
    
    /*
        テキストの更新
    */
    internal func setText()->Bool
    {
        //送りワード文字数チェック
        if(self.cntLnw != 0)
        {
            if(self.cntLct >= self.liplisNowWord.utf16Count)
            {
                //終了チェック
                if(self.checkEnd()){return true}
                
                //チャットテキストカウントの初期化
                self.cntLct = 0
                
                //なうワードの初期化
                self.liplisNowWord = self.liplisNowTopic.nameList[cntLnw]
                
                //プレブエモーションセット
                self.prvEmotion = self.nowEmotion
                
                //なうエモーションの取得
                self.nowEmotion = self.liplisNowTopic.emotionList[self.cntLnw]
                
                //なうポイントの取得
                self.nowPoint = self.liplisNowTopic.pointList[self.cntLnw]
                
                //インデックスインクリメント
                self.cntLnw = self.cntLnw + 1
            }
        }
        else if(self.cntLnw == 0)
        {
            //チャットテキストカウントの初期化
            self.cntLct = 0
            
            //空チェック
            if self.liplisNowTopic.nameList.count == 0
            {
                self.checkEnd()
                return true
            }
            
            //なうワードの初期化
            self.liplisNowWord = self.liplisNowTopic.nameList[self.cntLnw]

            //次ワード遷移
            self.cntLnw = self.cntLnw + 1
            
            //空だったら、空じゃなくなるまで繰り返す
            if(self.liplisNowWord == "")
            {
                do
                {
                    //チェックエンド
                    checkEnd()
                    
                    //終了チェック
                    if(self.cntLnw>self.liplisNowTopic.nameList[cntLnw].utf16Count){break}
                    
                    //ナウワードの初期化
                    self.liplisNowWord = self.liplisNowTopic.nameList[self.cntLnw]

                    //次ワード遷移
                    self.cntLnw = self.cntLnw + 1
                }
                while(self.liplisNowWord == "")
            }
        }
        else
        {
            
        }
        //おしゃべり
        self.liplisChatText = self.liplisChatText + (self.liplisNowWord as NSString).substringWithRange(NSRange(location : self.cntLct,length : 1))
        self.cntLct = self.cntLct + 1
        
        return false
    }
    
    /*
        テキストビューの更新
    */
    internal func updateText()
    {
        self.lblLpsTalkLabel.text = self.liplisChatText
    }
    
    /*
        ボディの更新
    */
    internal func updateBody()->Bool
    {
        //感情変化セット
        self.setObjectBody()
        
        //口パクカウント
        if(self.flgChatting)
        {
            if(self.cntMouth == 1){self.cntMouth = 2}
            else             {self.cntMouth = 1}
        }
        else
        {
            self.cntMouth = 1
        }
        
        //めぱちカウント
        if(self.cntBlink == 0){self.cntBlink = self.getBlincCnt()}
        else             {self.cntBlink = self.cntBlink - 1}
        
        autoreleasepool { () -> () in
            self.imgBody.image = nil
            self.imgBody.image = self.ob.getLiplisBodyImgIdIns(self.getBlinkState(),mouthState: self.cntMouth)
            self.imgBody.setNeedsDisplay()
        }
       
        return true
    }

    /*
    ボディの更新
    */
    internal func updateBodySitDown()
    {
        self.imgBody.image = nil
        self.imgBody.image = self.lpsBody.sleep
    }
    
    
    
    
    
    //============================================================
    //
    //ボディ制御
    //
    //============================================================
    
    /*
        ボディの取得
    */
    internal func setObjectBody()->Bool
    {
        if(self.nowEmotion != self.prvEmotion && self.flgChatting)
        {
            //バッテリーレベルによる容姿変化の処理はここに入れる
            
            //現在の感情値、感情レベルからボディを一つ取得
            self.ob = lpsBody.getLiplisBody(nowEmotion, point: nowPoint)
            
            return true
        }
        
        return false
    }
    
    /*
        ボディを初期状態に戻す
    */
    internal func setObjectBodyNeutral()->Bool
    {
        self.cntMouth = 1
        self.cntBlink = 0
        self.nowEmotion = 0
        self.nowPoint = 0
        
        if self.os.lpsHealth == 1 && self.lpsBattery.batteryNowLevel > 75
        {
            //ヘルス設定ONでバッテリー残量が７５％以下なら小破以下の画像取得
            self.ob = self.lpsBody.getLiplisBodyHelth(Int(self.lpsBattery.batteryNowLevel), emotion: self.nowEmotion, point: self.nowPoint)
        }
        else
        {
            self.ob = self.lpsBody.getLiplisBody(self.nowEmotion, point : self.nowPoint)
        }
        
        //reqReflesh()
        
        return true
    }
    
    
    /*
        まばたきカウント
    */
    internal func getBlincCnt()->Int{
        return LiplisUtil.getRandormNumber(Min: 30,Max: 50)
    }
    
    /*
        まばたき状態の取得
    */
    internal func getBlinkState()->Int
    {
        switch(self.cntBlink)
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
    internal func herfEyeCheck()
    {
        if(self.cntBlink == 1 || self.cntBlink == 3)
        {
            self.cntBlink = 0
            self.updateBody()
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
    internal func chatStart()
    {
        self.flgChatting = true
        
        //瞬時表示チェック
        if self.os.lpsSpeed == 3
        {
            self.immediateRefresh()
        }
        else
        {
            //実行モードを12に設定する
            self.flgAlarm = 12
            
            //更新タイマーをONする
            self.startUpdateTimer()
        }
    }
    
    /*
        チャットストップ
    */
    internal func chatStop()
    {
        self.flgAlarm = 0
        
        self.reSetUpdateCount()
        
        self.flgChatting = false
        self.flgSkip = false
    }
    
    
    //============================================================
    //
    //話題管理
    //
    //============================================================
    
    /*
        1件のトピックを取得する
    */
    internal func getTopic()
    {
        self.flgChatTalk = false
        self.flgThinking = true
        
        self.getShortNews()
        
        self.flgThinking = false
    }
    
    
    
    /*
        ニュースキューチェック
    */
    internal func onCheckNewsQueue()
    {
        if(!self.flgSitdown)
        {
            self.lpsNews.checkNewsQueue(self.getPostDataForLiplisNewsList())
        }
    }
    
    /*
        ニュースを取得する
    */
    internal func getShortNews()
    {
        self.liplisNowTopic = self.lpsNews.getShortNews(self.getPostDataForLiplisNews())
        
        //取得失敗メッセージ
        if self.liplisNowTopic == nil
        {
            self.self.liplisNowTopic = FctLiplisMsg.createMsgMassageDlFaild()
            liplisUrl = ""
        }
        else
        {
            self.liplisUrl = self.liplisNowTopic.url
        }
        
    }
    
    /*
        ポストパラメーターの作成(ニュース単体向け)
    */
    internal func getPostDataForLiplisNews()->NSData
    {
        var nameValuePair : NameValuePair = NameValuePair()
        nameValuePair.add(BasicNameValuePair(key: "tone", value: self.lpsSkin.tone))
        nameValuePair.add(BasicNameValuePair(key: "newsFlg", value: self.os.getNewsFlg()))
        nameValuePair.add(BasicNameValuePair(key: "randomkey", value: LiplisDate().getTimeStr()))   //キャッシュ防止
        return nameValuePair.getPostData()
    }
    
    /*
        ポストパラメーターの作成(ニュースリスト向け)
    */
    internal func getPostDataForLiplisNewsList()->NSData
    {
        var nameValuePair : NameValuePair = NameValuePair()
        nameValuePair.add(BasicNameValuePair(key: "userid", value: self.desk.baseSetting.lpsUid))
        nameValuePair.add(BasicNameValuePair(key : "tone", value: self.lpsSkin.tone))
        nameValuePair.add(BasicNameValuePair(key: "newsFlg", value: self.os.getNewsFlg()))
        nameValuePair.add(BasicNameValuePair(key : "num", value: "20"))
        nameValuePair.add(BasicNameValuePair(key: "hour", value: self.os.getLpsNewsRangeStr()))
        nameValuePair.add(BasicNameValuePair(key: "already", value: String(self.os.lpsNewsAlready)))
        nameValuePair.add(BasicNameValuePair(key: "twitterMode", value: String(self.os.lpsTopicTwitterMode)))
        nameValuePair.add(BasicNameValuePair(key: "runout", value: String(self.os.lpsNewsRunOut)))
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
    internal func wakeup()
    {
        //おやすみ状態の場合、ウェイクアップ
        self.flgSitdown = false
        
        //アイコン変更
        self.icoSleep.setImage(self.lpsIcon.imgSleep,forState : UIControlState.Normal)
        
        //あいさつ
        self.greet()
    }
    
    /*
    おやすみ
    */
    internal func sleep()
        {
        //ウェイクアップ状態の場合、おやすみ
        self.flgSitdown = true
        
        //アイコン変更
        self.icoSleep.setImage(self.lpsIcon.imgWakeup,forState : UIControlState.Normal)
        
        //表示テキスト変更
        self.lblLpsTalkLabel.text = "zzz"
        
        //おやすみの立ち絵に変更
        self.updateBodySitDown()
    }
    
    /*
    アイコン表示
    */
    internal func iconOn()
    {
        self.icoSleep.hidden = false
        self.icoLog.hidden = false
        self.icoSetting.hidden = false
        self.icoChat.hidden = false
        self.icoClock.hidden = false
        self.icoBattery.hidden = false
    }
    
    /*
    アイコン非表示
    */
    internal func iconOff()
    {
        self.icoSleep.hidden = true
        self.icoLog.hidden = true
        self.icoSetting.hidden = true
        self.icoChat.hidden = true
        self.icoClock.hidden = true
        self.icoBattery.hidden = true
    }
    
    /*
    最前面に移動する
    */
    internal func goToTheFront()
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
    internal func callWidgetSetting()
    {
        let modalView : ViewWidgetMenu = ViewWidgetMenu(widget: self)
        modalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.desk.presentViewController(modalView, animated: true, completion: nil)
    }
    
    /*
    チャット画面を呼び出す
    */
    internal func callChat()
    {
        let modalView : ViewChat = ViewChat(widget : self)
        modalView.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        modalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            
        self.desk.presentViewController(modalView, animated: true, completion: nil)
    }
}