//
//  EntityScore.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/2.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityScore.h"

@implementation EntityScore
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    EntityScore *t = [[[EntityScore alloc]init]Init];
    t.goodsName    = dic[@"goodsName"];
    t.totalTimes   = dic[@"totalTimes"];
    t.remainTimes    = dic[@"remainTimes"];
    t.expireDate    = dic[@"expireDate"];
    t.Id    = dic[@"id"];
    return t;
}
@end
