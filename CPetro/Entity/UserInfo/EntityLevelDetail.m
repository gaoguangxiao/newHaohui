//
//  EntityLevelDetail.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/2.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityLevelDetail.h"

@implementation EntityLevelDetail
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    EntityLevelDetail *t = [[[EntityLevelDetail alloc]init]Init];
    t.memberName         = dic[@"memberName"];
    t.levelName         = dic[@"levelName"];
    t.betMoney         = dic[@"betMoney"];
    t.upgradeMoney         = dic[@"upgradeMoney"];
    t.luckyMoney         = dic[@"luckyMoney"];
    t.compareMoney         = dic[@"compareMoney"];
    return t;
}
@end
