//
//  EntityLevelDetail.h
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/2.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityObject.h"

@interface EntityLevelDetail : EntityObject
@property(nonatomic,copy)NSString *memberName;
@property(nonatomic,copy)NSString *levelName;
@property(nonatomic,copy)NSString *betMoney;//累计有效投注
@property(nonatomic,copy)NSString *upgradeMoney;//upgradeMoney
@property(nonatomic,copy)NSString *luckyMoney;
@property(nonatomic,copy)NSString *compareMoney;
@end
