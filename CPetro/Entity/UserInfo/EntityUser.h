//
//  EntityUser.h
//  SimpleSrore
//
//  Created by ggx on 2017/3/16.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EntityObject.h"

@interface EntityUser : EntityObject
@property(nonatomic,copy)NSString *levelName;
@property(nonatomic,copy)NSString *memberName;//用户名
@property(nonatomic,copy)NSString *clientId;//客户端绑定码
@property(nonatomic,copy)NSString *signTimes;//连续签到次数
@property(nonatomic,copy)NSString *coin;//虚拟货币数量
@property(nonatomic,copy)NSString *point;//会员积分
@end
