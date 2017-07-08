//
//  NSDictionary+Json.m
//  CPetro
//
//  Created by ggx on 2017/3/10.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)
- (NSString *)convertToJSONString{
    if ([NSJSONSerialization isValidJSONObject:self]){
//        NSError *error = nil;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error: &error];
        NSString *jstrParam = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:0 error:nil] encoding:NSUTF8StringEncoding];
        return jstrParam;
    }
    return nil;
}
@end
