//
//  StringBuilder.swift
//  Liplis
//
//  StringBuilder JavaやC#のStringBuilderを模したクラス
//
//アップデート履歴
//   2015/04/27 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//
//  Created by sachin on 2015/04/27.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
/**
Supports creation of a String from pieces
*/
public class StringBuilder {
    private var stringValue: String
    
    /**
    Construct with initial String contents
    
    :param: string Initial value; defaults to empty string
    */
    public init(string: String = "") {
        self.stringValue = string
    }
    
    /**
    Return the String object
    
    :return: String
    */
    public func toString() -> String {
        return stringValue
    }
    
    /**
    Return the current length of the String object
    */
    public var length: Int {
        return count(stringValue)
    }
    
    /**
    Append a String to the object
    
    :param: string String
    
    :return: reference to this StringBuilder instance
    */
    public func append(string: String) -> StringBuilder {
        stringValue += string
        return self
    }
    
    /**
    Append a Printable to the object
    
    :param: value a value supporting the Printable protocol
    
    :return: reference to this StringBuilder instance
    */
    public func append<T: Printable>(value: T) -> StringBuilder {
        stringValue += value.description
        return self
    }
    
    /**
    Append a String and a newline to the object
    
    :param: string String
    
    :return: reference to this StringBuilder instance
    */
    public func appendLine(string: String) -> StringBuilder {
        stringValue += string + "\n"
        return self
    }
    
    /**
    Append a Printable and a newline to the object
    
    :param: value a value supporting the Printable protocol
    
    :return: reference to this StringBuilder instance
    */
    public func appendLine<T: Printable>(value: T) -> StringBuilder {
        stringValue += value.description + "\n"
        return self
    }
    
    /**
    Reset the object to an empty string
    
    :return: reference to this StringBuilder instance
    */
    public func clear() -> StringBuilder {
        stringValue = ""
        return self
    }
}