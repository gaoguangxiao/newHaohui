//
//  EntityUser.m
//  SimpleSrore
//
//  Created by ggx on 2017/3/16.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityUser.h"

@implementation EntityUser
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    EntityUser *t = [[[EntityUser alloc]init]Init];
    t.levelName = dic[@"levelName"];
    t.memberName = dic[@"memberName"];
    t.clientId   = dic[@"clientId"];
    
    t.signTimes  = dic[@"signTimes"];
    t.point      = dic[@"point"];
    
    if (!t.levelName) t.levelName = @"0";
    return t;
    
}
@end
