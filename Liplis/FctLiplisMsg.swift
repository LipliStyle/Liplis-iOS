//
//  FctLiplisMsg.swift
//  Liplis
//
//  Created by sachin on 2015/04/18.
//  Copyright (c) 2015年 sachin. All rights reserved.
//

import Foundation
struct FctLiplisMsg {
    static func createMsgMassageDlFaild()->MsgShortNews
    {
        var msg : MsgShortNews = MsgShortNews()
        
        msg.nameList.append("データ")
        msg.nameList.append("の");
        msg.nameList.append("取得");
        msg.nameList.append("に");
        msg.nameList.append("失敗");
        msg.nameList.append("し");
        msg.nameList.append("まし");
        msg.nameList.append("た。");
        
        msg.emotionList.append(1);
        msg.emotionList.append(1);
        msg.emotionList.append(1);
        msg.emotionList.append(1);
        msg.emotionList.append(1);
        msg.emotionList.append(1);
        msg.emotionList.append(1);
        msg.emotionList.append(1);
        
        msg.pointList.append(-1);
        msg.pointList.append(-1);
        msg.pointList.append(-1);
        msg.pointList.append(-1);
        msg.pointList.append(-1);
        msg.pointList.append(-1);
        msg.pointList.append(-1);
        msg.pointList.append(-1);
                    
        return msg;
    
    }
}