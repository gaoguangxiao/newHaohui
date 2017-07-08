//
//  EntityAd.m
//  hongbao
//
//  Created by 王书倌 on 15/4/25.
//  Copyright (c) 2015年 wang shuguan. All rights reserved.
//

#import "EntityAd.h"

@implementation EntityAd
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic
{
    EntityAd *t = [[EntityAd alloc] init];
    t.title = dic[@"title"];
    t.zhaiyao = dic[@"content"];
    t.createTime = dic[@"createTime"];

    return t;
}

-(void)setTitle:(NSString *)title{
    _title = [self dealData:title withVar:_title];
}
-(void)setCreateTime:(NSString *)createTime{
    _createTime = [self dealData:createTime withVar:_createTime];
}

-(void)setZhaiyao:(NSString *)zhaiyao{
    _zhaiyao = [self dealData:zhaiyao withVar:_zhaiyao];
}

-(NSString *)name{
    return _title;
}

@end
