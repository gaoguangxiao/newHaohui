//
//  EntityMessager.m
//  SimpleSrore
//
//  Created by ggx on 2017/3/17.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityMessager.h"

@implementation EntityMessager
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    EntityMessager *t = [[EntityMessager alloc]init];
    t.memberName      = dic[@"memberName"];
    t.awardName       = dic[@"awardName"];
    
//    t.createTime      = dic[@"createTime"];
    NSDateFormatter *outPutStr = [NSDateFormatter dateFormatterWithFormat:@"yyyy年MM月dd日"];
    NSString *addTime = [outPutStr stringFromDate:[U_SERVER_FORMATTER dateFromString:dic[@"createTime"]]];
    t.createTime = addTime;//重新
    t.titleText  = dic[@"awardName"];
    return t;
}
@end
