//
//  NameValuePair.swift
//  Liplis
//
//  Created by sachin on 2015/04/18.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
class NameValuePair {
    var nvp : Dictionary<String,String>!
    
    /**
        コンストラクター
    */
    init()
    {
        nvp = Dictionary<String,String>()
    }
    
    /**
        要素追加
    */
    func add(bnv : BasicNameValuePair)
    {
        nvp[bnv.key] = bnv.value
    }
    
    /**
        ポストデータを取得する
    */
    func getPostData()->NSData
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