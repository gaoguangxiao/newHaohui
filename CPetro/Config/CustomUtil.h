//
//  CustomUtil.h
//  SimpleSrore
//
//  Created by ggx on 2017/3/15.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import <Foundation/Foundation.h>
//用户信息
#import "EntityUser.h"
#define U_TOKEN @"TOKEN"
#define U_INFO @"U_INFO"
@interface CustomUtil : NSObject
+(BOOL)isUserLogin;
+(void)saveAcessToken:(NSString *)token;
+(void)delAcessToken;
+(NSString *)getToken;

//保存用户信息
+(void)saveUserInfo:(EntityUser *)info;
//获取用户信息
+(EntityUser *)getUserInfo;
//删除用户信息
+(void)deleUserInfo;
@end
