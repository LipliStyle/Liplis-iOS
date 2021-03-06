//
//  ArrayStackQueueExtensions.swift
//  Liplis
//
//  Arrayのエクステンション
//
//アップデート履歴
//   2015/04/27 ver0.1.0 作成
//   2015/05/09 ver1.0.0 リリース
//   2015/05/16 ver1.4.0　ファイル名変更
//
//  Created by sachin on 2015/04/11.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation

extension Array {
    
    //============================================================
    //
    //Stack - LIFO
    //Arrayをスタックとして使うための拡張
    //============================================================
    mutating func push(newElement: Element) {
        self.append(newElement)
    }
    
    mutating func pop() -> Element? {
        return self.removeLast()
    }
    
    func peekAtStack() -> Element? {
        return self.last
    }
    
    //============================================================
    //
    //Queue - FIFO
    //Arrayをキューとして使うための拡張
    //============================================================
    mutating func enqueue(newElement: Element) {
        self.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        return self.removeAtIndex(0)
    }
    
    func peekAtQueue() -> Element? {
        return self.first
    }
    
    //============================================================
    //
    //shuffle
    //配列をシャッフルするための拡張
    // 現状、使えいない？
    //============================================================
    mutating func shuffle() {
        var result : Array<Element> = Array<Element>()
        let cnt = self.count
        
        //ランダムに並べ直す
        for var i = 0; i<cnt; i++
        {
            let idx = Int(arc4random()) % self.count
            
            result.append(self[idx])
            self.removeAtIndex(idx)
        }
        
        //並べ直した結果をセットし直す
        self = result
    }
    
    //============================================================
    //
    //addRange
    //配列を追加する
    //============================================================
    mutating func addRange(addArray : Array<Element>) {
        for item in addArray
        {
            self.append(item)
        }
    }
    
    //============================================================
    //
    //配列コンストラクター
    //
    //============================================================
    init(lst : Array<Element>)
    {
        self = lst
    }
    
    //============================================================
    //
    //contains
    //
    //============================================================
//    mutating func contains(target : T)->Bool
//    {
//        for item in self
//        {
//            //一致するものがあった場合、存在と判断
//            if item === target
//            {
//                return true
//            }
//        }
//        
//        //非存在
//        return false
//    }
}