//
//  EntityAssistant.m
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityAssistant.h"

@implementation EntityAssistant
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    EntityAssistant *t = [[EntityAssistant alloc]init];
    t.assistantName    = @"贾宝玉";
    t.assistantAccount = @"jiabaoyu";
    t.assistantPwd     = @"000000";
    t.assistantStatus  = @"正常";
    return t;
}
@end
