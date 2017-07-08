//
//  EntityCatalog.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/2.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityCatalog.h"

@implementation EntityCatalog
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    EntityCatalog *t = [[[EntityCatalog alloc]init]Init];
    t.catalogId      = dic[@"catalogId"];
    t.catalogName    = dic[@"catalogName"];
    return t;
}
@end
