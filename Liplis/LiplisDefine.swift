//
//  LiplisDefine.swift
//  Liplis
//
//  Liplisの定義を記述する構造体
//
//アップデート履歴
//   2015/04/12 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/14 ver1.3.0　リファクタリング
//
//  Created by sachin on 2015/04/12.
//  Copyright (c) 2015年 sachin. All rights reserved.
//
import UIKit
import Foundation

struct LiplisDefine
{
    ///=============================
    /// API URL
    internal static let API_SHORT_NEWS_URL_NEW :  String = "http://liplis.mine.nu/Clalis/v40/Liplis/ClalisForLiplisWeb.aspx"                    //ショートニュースAPI
    internal static let API_SHORT_NEWS_URL_LSIT : String = "http://liplis.mine.nu/Clalis/v40/Liplis/ClalisForLiplisWebFx.aspx"                  //ショートニュースリストAPI
    internal static let API_ONETIME_PASS :        String = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisGetOnetimePass.aspx"         //ワンタイムパスワード要求API
    internal static let API_TWITTER_INFO_REGIST : String = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisRegisterTwitterInfo.aspx"    //ツイッターユーザー登録API
    internal static let API_TWITTER_USER_ADD :    String = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisRegisterAddTwitterUser.aspx"	//ツイッターユーザー登録API
    internal static let API_TWITTER_USER_DEL :    String = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisRegisterDelTwitterUser.aspx"	//ツイッターユーザー削除API
    internal static let API_RSS_URL_ADD :         String = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisRegisterAddRssUrl.aspx"      //RSS URL登録API
    internal static let API_RSS_URL_DEL :         String = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisRegisterDelRssUrl.aspx"      //RSS URL削除API
    internal static let API_TWITTER_USER_LIST :   String = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisSettingTwitterUserList.aspx" //TwitterUserリスト取得API
    internal static let API_RSS_URL_LIST :        String = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisSettingRssUrlList.aspx"      //RSSユーザーリスト取得API
    internal static let API_SETTING_LIST :        String = "http://liplis.mine.nu/Clalis/v32/Liplis/ClalisForLiplisSettingGetSearchWord.aspx"   //話題検索設定リスト取得API
    internal static let API_SETTING_ADD :         String = "http://liplis.mine.nu/Clalis/v32/Liplis/ClalisForLiplisSettingAddSearchWord.aspx"   //話題検索設定追加API
    internal static let API_SETTING_DEL :         String = "http://liplis.mine.nu/Clalis/v32/Liplis/ClalisForLiplisSettingDelSearchWord.aspx"	//話題検索設定削除API
    internal static let API_TOPIC_SETTING :       String = "http://liplis.mine.nu/Clalis/v32/Liplis/ClalisForLiplisSettingTopicSetting.aspx"    //話題設定
    internal static let API_SHORT_NEWS_IN_URL :   String = "http://liplis.mine.nu/clalis/v30/liplis/clalis.asmx/clalisShortNewsIn"	//ショートニュースインターナショナルAPI
    internal static let API_LIPLIS_ERROR :        String = "http://liplis.mine.nu/Clalis/v20/Api.asmx/sendErr"									//エラー送信
    internal static let API_LIPLIS_CHAT :         String = "http://liplis.mine.nu/Clalis/v40/Liplis/ClalisForLiplisTalk.aspx"					//おしゃべり応答
    
    ///=============================
    /// サイト URL
    internal static let SITE_LIPLISTYLE :                  String = "http://liplis.mine.nu/"                                                    //リプリスタイル公式サイト
    internal static let SITE_LIPLIS_HELP :                 String = "http://liplis.mine.nu/lipliswiki/webroot/?Liplis%20iOS%20Manual"           //リプリスIOSヘルプ
    
    ///=============================
    /// デフォルトスキン名
    internal static let SKIN_NAME_DEFAULT :                String = "LiliRenew_Default"                                                         //デフォルトスキン名
    
    ///=============================
    ///オフセット定数
    internal static let labelHight : CGFloat = 60.0
    internal static let headerHight : CGFloat = 25.0
    internal static let futterHight : CGFloat = 50.0
    
    ///=============================
    /// 設定部品定数
    internal static let PARTS_TYPE_TITLE       = 0 //タイトル
    internal static let PARTS_TYPE_CHECK       = 1 //チェックボックス
    internal static let PARTS_TYPE_SWITCH      = 2 //スイッチ
    internal static let PARTS_TYPE_RADIO       = 3 //ラジオボタン定義
    internal static let PARTS_TYPE_RADIO_CHILD = 4 //ラジオボタン子
    
    ///=============================
    ///終端マーク
    internal static let EOS = "EOS"
    
    
    
    
    
}