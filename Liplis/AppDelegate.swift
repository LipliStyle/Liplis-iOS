//
//  AppDelegate.swift
//  Liplis
//
//  アプリのライフタイムイベント管理
//  画面インスタンスを全て管理し、データの受け渡しをしやすくする。
//  キャラクターデータは、キャラクター選択画面、デスクトップのウィジェットで使用するため、ここでインスタンスを保持。
//
//
//アップデート履歴
//   2015/01/04 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/12 ver1.1.0 ObjLiplisBodyで管理しているボディのリストの最後尾が使用されていなかった問題修正
//   2015/05/13 ver1.2.0 ログの送りバグ修正
//   2015/05/14 ver1.3.0 ウェイクアップ時にスキンの削除チェック
//                       キャラクター画面切り替え時、再ロード(スキン削除時のバグ対応)
//   2015/05/16 ver1.4.0 Swift1.2対応
//   2015/05/19 ver1.4.1 話題2chを凍結、デフォルト選択話題をニュースのみに設定
//   　　　　　　　　　　　　会話中にすぐに通常おしゃべりに戻るバグ修正
//
//
//  Created by sachin on 2015/01/04.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import UIKit
import Foundation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    ///=============================
    /// ステータス
    internal var window: UIWindow?

    ///=============================
    /// 画面
    internal var activityDeskTop: ViewDeskTop!           //デスクトップ画面
    internal var activityMenu: ViewSettingMenu!          //設定メニュー
    internal var activityCharcter: ViewCharacter!        //キャラクター選択画面
    internal var activityLog: ViewLog!                   //ログ画面
    internal var activityWeb: ViewWeb!                   //ウェブ画面
    internal var myTabBarController: UITabBarController! //タブコントロール

    ///=============================
    /// キャラクターデータ管理
    internal var cman : LiplisCharDataManager!
    
    //============================================================
    //
    //ライフサイクルイベント
    //
    //============================================================

    /**
    アプリケーション開始時処理
    */
    internal func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //Liplisの初期化
        initLiplis()
        return true
    }
    
    /**
    アプリケーションが非アクティブ状態に遷移する時に送信される。
    例えば(電話の着信やSMSメッセージのような)一時的な中断が発生する場合に、進行中のタスクを無効にし、タイマーを一時停止、
    OpenGL ESのフレームレートを下げるために、このメソッドを使用する。
    */
    internal func applicationWillResignActive(application: UIApplication) {
    }

    /**
    アプリケーションバックグラウンド遷移時
    */
    internal func applicationDidEnterBackground(application: UIApplication) {
        //デスクトップにバックグラウンド遷移イベントを起こす。(おやすみ処理など)
        activityDeskTop.onBackGround()
    }

    /**
    アプリケーションフォアグラウンド遷移時
    */
    internal func applicationWillEnterForeground(application: UIApplication) {
        //デスクトップにフォアグラウンド遷移イベントを起こす。(起きる処理など)
        activityDeskTop.onForeGround()
    }
    
    /**
    アプリケーションが非アクティブまたは一時停止(または未開始)されていたタスクを再起動するときに呼ばれる
    */
    internal func applicationDidBecomeActive(application: UIApplication) {
    }

    /**
    アプリ終了時に呼ばれる
    データ保存の必要がある場合はここで行う。
    */
    internal func applicationWillTerminate(application: UIApplication) {
    }

    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    Liplisの初期化
    */
    private func initLiplis()
    {
        //ウインドウ生成
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //キャラクターデータの読み込み
        self.cman = LiplisCharDataManager()
        
        //画面のインスタンス化
        self.activityDeskTop = ViewDeskTop(app: self)
        self.activityMenu = ViewSettingMenu(app: self)
        self.activityCharcter = ViewCharacter(app: self)
        self.activityLog = ViewLog(app: self)
        self.activityWeb = ViewWeb(app: self)
        
        // タブを要素に持つArrayの.を作成する.
        let activityList = NSArray(objects: activityDeskTop!, activityMenu!,activityCharcter!,activityLog!,activityWeb!)
        
        // UITabControllerの作成する.
        self.myTabBarController = UITabBarController()
        
        // ViewControllerを設定する.
        self.myTabBarController?.setViewControllers(activityList as [AnyObject], animated: false)
        
        // RootViewControllerに設定する.
        self.window!.rootViewController = myTabBarController
        
        self.window!.makeKeyAndVisible()
        
    }
}

