//
//  HomeOrderEntity.h
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityObject.h"

@interface HomeOrderEntity : EntityObject
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *orderTime;
@end
