//
//  EntityGoods.h
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/2.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityObject.h"

@interface EntityGoods : EntityObject

@property(nonatomic,copy)NSString *goodsName;
@property(nonatomic,copy)NSString *needPoint;
@property(nonatomic,copy)NSString *goodsType;
@property(nonatomic,copy)NSString *period;
@property(nonatomic,copy)NSString *goodsId;
//"goodsType": "2",
//"period": 7,
//"goodsId": 3

@end
