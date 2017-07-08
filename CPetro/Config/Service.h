//
//  Service.h
//  CPetro
//
//  Created by ggx on 2017/3/10.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

#import "CGDataResult.h"

typedef void (^returnObject)(CGDataResult *obj);

@interface Service : NSObject


@property(nonatomic,strong) AFHTTPSessionManager * manager;
/**
 *  获取网络数据
 *
 *  @param parameters @{}
 *  @param methodName 接口名字
 *
 *  @return return value description
 */
+(CGDataResult *)loadNetWorkingByParameters:(NSDictionary *)parameters andBymethodName:(NSString *)methodName;

//+(void)postImageByUrl:(NSString*)url withParameters:(NSDictionary*)parameters andImageData:(NSData*)imageData imageKey:(NSString *)imageKey andComplain:(returnObject)complain;
@end
