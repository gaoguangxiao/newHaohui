//
//  EntityLineCheck.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/2.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityLineCheck.h"

@implementation EntityLineCheck
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    EntityLineCheck *t = [[[EntityLineCheck alloc]init]Init];
    t.Id = dic[@"id"];
    t.url = dic[@"url"];
    return t;
}
@end
