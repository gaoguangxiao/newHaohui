//
//  CGDataResult.h
//  CPetro
//
//  Created by ggx on 2017/3/10.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGDataResult : NSObject
@property(strong,nonatomic)NSString *errorMsg;
@property(strong,nonatomic)NSNumber *status;
@property(strong,nonatomic)id dataList;

+(CGDataResult *)getResultFromData:(NSDictionary *)dic;

//+(CGDataResult *)getResultFromDic:(NSDictionary *)dic;
@end
