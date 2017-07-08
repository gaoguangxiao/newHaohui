//
//  HomeOrderEntity.m
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "HomeOrderEntity.h"

@implementation HomeOrderEntity
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    HomeOrderEntity *t = [[HomeOrderEntity alloc]init];
//    t.orderTime = @"2017.03.30";
//    t.orderId   = @"12322522";
    return t;
}
@end
