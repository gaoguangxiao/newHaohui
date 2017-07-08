//
//  EntityAssistant.h
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityObject.h"

@interface EntityAssistant : EntityObject
@property(nonatomic,copy)NSString *assistantName;
@property(nonatomic,copy)NSString *assistantAccount;
@property(nonatomic,copy)NSString *assistantPwd;
@property(nonatomic,copy)NSString *assistantStatus;
@property(nonatomic,copy)NSString *assistantStr;
@end
