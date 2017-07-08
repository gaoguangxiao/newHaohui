//
//  EntityMessager.h
//  SimpleSrore
//
//  Created by ggx on 2017/3/17.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityObject.h"

@interface EntityMessager : EntityObject
@property(nonatomic,copy)NSString *memberName;
@property(nonatomic,copy)NSString *awardName;

@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *titleText;
@end
