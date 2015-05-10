//
//  LiplisDefine.swift
//  Liplis
//
//  Created by kosuke on 2015/04/12.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
struct LiplisDefine
{
    ///=============================
    /// API URL
    static let API_SHORT_NEWS_URL_NEW : String 	= "http://liplis.mine.nu/Clalis/v40/Liplis/ClalisForLiplisWeb.aspx"                     //ショートニュースAPI
    static let API_SHORT_NEWS_URL_LSIT : String	= "http://liplis.mine.nu/Clalis/v40/Liplis/ClalisForLiplisWebFx.aspx"					//ショートニュースリストAPI
    static let API_ONETIME_PASS	: String	 	= "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisGetOnetimePass.aspx"			//ワンタイムパスワード要求API
    static let API_TWITTER_INFO_REGIST : String	= "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisRegisterTwitterInfo.aspx"     //ツイッターユーザー登録API
    static let API_TWITTER_USER_ADD : String	= "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisRegisterAddTwitterUser.aspx"	//ツイッターユーザー登録API
    static let API_TWITTER_USER_DEL : String	= "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisRegisterDelTwitterUser.aspx"	//ツイッターユーザー削除API
    static let API_RSS_URL_ADD : String	        = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisRegisterAddRssUrl.aspx"		//RSS URL登録API
    static let API_RSS_URL_DEL : String	        = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisRegisterDelRssUrl.aspx"		//RSS URL削除API
    static let API_TWITTER_USER_LIST : String   = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisSettingTwitterUserList.aspx"  //ツイッターユーザーリスト取得API
    static let API_RSS_URL_LIST	: String        = "http://liplis.mine.nu/Clalis/v31/Liplis/ClalisForLiplisSettingRssUrlList.aspx"		//RSSユーザーリスト取得API
    static let API_SETTING_LIST	: String        = "http://liplis.mine.nu/Clalis/v32/Liplis/ClalisForLiplisSettingGetSearchWord.aspx"	//話題検索設定リスト取得API
    static let API_SETTING_ADD : String         = "http://liplis.mine.nu/Clalis/v32/Liplis/ClalisForLiplisSettingAddSearchWord.aspx"    //話題検索設定追加API
    static let API_SETTING_DEL : String	        = "http://liplis.mine.nu/Clalis/v32/Liplis/ClalisForLiplisSettingDelSearchWord.aspx"	//話題検索設定削除API
    static let API_TOPIC_SETTING : String	    = "http://liplis.mine.nu/Clalis/v32/Liplis/ClalisForLiplisSettingTopicSetting.aspx"     //話題設定
    static let API_SHORT_NEWS_IN_URL : String	= "http://liplis.mine.nu/clalis/v30/liplis/clalis.asmx/clalisShortNewsIn"				//ショートニュースインターナショナルAPI
    static let API_LIPLIS_ERROR : String		= "http://liplis.mine.nu/Clalis/v20/Api.asmx/sendErr"									//エラー送信
    static let API_LIPLIS_CHAT : String			= "http://liplis.mine.nu/Clalis/v40/Liplis/ClalisForLiplisTalk.aspx"					//おしゃべり応答
    
    ///=============================
    /// サイト URL
    static let SITE_LIPLISTYLE : String			= "http://liplis.mine.nu/"                                                              //リプリスタイル公式サイト
    static let SITE_LIPLIS_HELP : String		= "http://liplis.mine.nu/lipliswiki/webroot/?Liplis%20iOS%20Manual"                     //リプリスIOSヘルプ
    
    
    
    ///=============================
    /// デフォルトスキン名
    static let SKIN_NAME_DEFAULT : String		= "LiliRenew_Default"                                                                    //デフォルトスキン名
    
}