//
//  AppDelegate.swift
//  Liplis
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
    var window: UIWindow?

    ///=============================
    /// 画面
    var activityDeskTop: ViewDeskTop!
    var activityMenu: ViewSettingMenu!
    var activityCharcter: ViewCharacter!
    var activityLog: ViewLog!
    var activityWeb: ViewWeb!
    
    var myTabBarController: UITabBarController!

    ///=============================
    /// キャラクターデータ管理
    var cman : LiplisCharDataManager!
    
    
    //============================================================
    //
    //初期化処理
    //
    //============================================================
    /**
    アプリケーション開始時処理
    */
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        //キャラクターデータの読み込み
        cman = LiplisCharDataManager()

        //画面のインスタンス化
        activityDeskTop = ViewDeskTop(app: self)
        activityMenu = ViewSettingMenu(app: self)
        activityCharcter = ViewCharacter(app: self)
        activityLog = ViewLog(app: self)
        activityWeb = ViewWeb(app: self)
        
        // タブを要素に持つArrayの.を作成する.
        let myTabs = NSArray(objects: activityDeskTop!, activityMenu!,activityCharcter!,activityLog!,activityWeb!)
        
        // UITabControllerの作成する.
        myTabBarController = UITabBarController()
        
        // ViewControllerを設定する.
        myTabBarController?.setViewControllers(myTabs as [AnyObject], animated: false)
        
        // RootViewControllerに設定する.
        self.window!.rootViewController = myTabBarController
        
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    /**
    アプリケーションバックグラウンド遷移時
    */
    func applicationDidEnterBackground(application: UIApplication) {
        activityDeskTop.onBackGround()
    }

    /**
    アプリケーションフォアグラウンド遷移時
    */
    func applicationWillEnterForeground(application: UIApplication) {
        activityDeskTop.onForeGround()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

