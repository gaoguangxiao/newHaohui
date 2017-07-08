//
//  ShareHandle.h
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-4.
//  Copyright (c) 2013年 ling. All rights reserved.
//

//#import "SingletonHandle.h"
#import <CoreLocation/CoreLocation.h>
@interface ShareHandle : NSObject
@property(nonatomic,copy)CLLocation *sharedLocation;
@property(nonatomic,assign)NSString *sharedLongitude;//经度
@property(nonatomic,assign)NSString *sharedLatitude;//维度
@property(nonatomic,copy)NSString *sharedCity;
@property(nonatomic,copy)NSString *sharedProvince;
@end
@interface NSDateFormatter(mydateformmater)
+(id)dateFormatterWithFormat:(NSString *)s;
@end

//给一个时间戳 返回一个未来的时间
@interface NSCalendar(mycalendea)
+(NSString *)calenderWithCalender:(NSUInteger )s;
@end