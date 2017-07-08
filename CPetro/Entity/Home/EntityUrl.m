//
//  EntityUrl.m
//  embeddedName
//
//  Created by gaoguangxiao on 2017/3/30.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityUrl.h"

@implementation EntityUrl
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    EntityUrl *t  = [[[EntityUrl alloc]init]Init];
    t.name         = dic[@"name"];
    t.type         = dic[@"type"];
    t.url          = dic[@"url"];
    return t;
}
@end
