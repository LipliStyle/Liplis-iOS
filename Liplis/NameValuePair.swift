//
//  NameValuePair.swift
//  Liplis
//
//  C#のNameValuePairエミュレート
//
//アップデート履歴
//   2015/04/17 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//
//  Created by sachin on 2015/04/18.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class NameValuePair {
    internal var nvp : Dictionary<String,String>!
    
    /**
        コンストラクター
    */
    internal init()
    {
        nvp = Dictionary<String,String>()
    }
    
    /**
        要素追加
    */
    internal func add(bnv : BasicNameValuePair)
    {
        nvp[bnv.key] = bnv.value
    }
    
    /**
        ポストデータを取得する
    */
    internal func getPostData()->NSData
    {
        var postStr : String = ""
        for(key,value) in nvp
        {
            postStr = postStr + key + "=" + value + "&"
        }
        
        return postStr.dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    
}

class BasicNameValuePair {
    var key : String!
    var value : String!
    init(key : String, value : String)
    {
        self.key = key
        self.value = value
    }
}