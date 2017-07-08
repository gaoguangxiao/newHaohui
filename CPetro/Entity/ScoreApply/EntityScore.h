//
//  EntityScore.h
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/2.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityObject.h"

@interface EntityScore : EntityObject
@property(nonatomic,copy)NSString *goodsName;
@property(nonatomic,copy)NSString *totalTimes;
@property(nonatomic,copy)NSString *remainTimes;
@property(nonatomic,copy)NSString *expireDate;
@property(nonatomic,copy)NSString *Id;
//"goodsName": "500新濠币",
//"totalTimes": 10,
//"remainTimes": 2,
//"expireDate": "2016-12-15",
//"id": 3

@end
