//
//  ChartMessage.m
//  tulingIOS
//
//  Created by Colin on 14-8-9.
//  Copyright (c) 2014年 icephone. All rights reserved.
//


#import "ChartMessage.h"

@implementation ChartMessage
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    ChartMessage *t = [[[ChartMessage alloc]init]Init];
    
    t.createTime=dic[@"createTime"];
    t.memberName  = dic[@"memberName"];
    t.content = dic[@"content"];
    t.messageType= dic[@"msgType"];
//    if (t.messageType == kMessageTo) {
//        t.icon =  @"icon01";
//    }else{
//         t.icon = @"icon1";
//    }
    return t;
}
//-(void)setDict:(NSDictionary *)dict
//{
//    _dict=dict;
//
//   
//}
@end
