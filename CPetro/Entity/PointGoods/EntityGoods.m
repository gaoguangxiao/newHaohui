//
//  EntityGoods.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/2.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityGoods.h"

@implementation EntityGoods
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    EntityGoods *t = [[[EntityGoods alloc]init]Init];
    t.goodsName    = dic[@"goodsName"];
    t.needPoint    = dic[@"needPoint"];
    t.goodsType    = dic[@"goodsType"];
    t.period       = dic[@"period"];
    t.goodsId      = dic[@"goodsId"];
    return t;
}
@end
