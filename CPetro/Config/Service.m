//
//  Service.m
//  CPetro
//
//  Created by ggx on 2017/3/10.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "Service.h"

#import "NSDictionary+Json.h"

static AFHTTPSessionManager *manager;

@implementation Service
//
+(AFHTTPSessionManager *)shareSessionManger{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
    });
    return manager;
    
}
+(CGDataResult *)loadNetWorkingByParameters:(NSDictionary *)parameters andBymethodName:(NSString *)methodName{
    return [CGDataResult getResultFromData:[Service backDataResults_webService:methodName AndDic:parameters]];
}

+(NSDictionary *)backDataResults_webService:(NSString *)webService AndDic:(NSDictionary *)dicTionary{
    NSString *urlNew = [NSString stringWithFormat:@"%@%@",WEBSEARVICE,webService];
    
    //1、查看字典中的clientId是否为空
    
    NSMutableDictionary *dic111 = [[NSMutableDictionary alloc]initWithDictionary:dicTionary];
    [self logLoadRequestUrl:urlNew withpara:dic111];
    
    AFHTTPRequestSerializer *requestOperation = [[AFHTTPRequestSerializer alloc] init];

//    URLLog(@"%@/%@",urlNew,[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dicTionary options:0 error:nil] encoding:NSUTF8StringEncoding]);
    
    NSMutableURLRequest *urlrequest =  [requestOperation requestWithMethod:@"POST" URLString:urlNew parameters:dicTionary error:nil];
    

    NSURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlrequest returningResponse:&reponse error:&error];
    
    //集合
    NSDictionary *dic = [NSDictionary new];

    if (error) {
        return @{};
        //        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData) {
            dic = [self getDicFromData:responseData];
            if (dic) {
                NSString *jstrParam = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic options:0 error:nil] encoding:NSUTF8StringEncoding];
                URLLog(@"%@",jstrParam);
            }

        }
//        if (![dic objectForKey:API_STATUS]) {
//            [dic setValue:@"false" forKey:API_STATUS];
//            [dic setValue:responseData?responseData:@"网络错误" forKey:API_MSG];
//            [dic setValue:[dic objectForKey:API_CONTENT] forKey:API_CONTENT];
//        }
        return dic;
    }
   
    
}
/**调试输出网址*/
//+(void)deletebugDic:(NSDictionary *)dicTionary andBugUrl:(NSString *)url{
//    //调试
//    NSMutableString *mutableString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@",url]];
//    for (NSString *key in dicTionary.allKeys) {
//        if ([dicTionary[key] isKindOfClass:[NSString class]]) {
//            NSString *value = dicTionary[key];
//            if (value.length<1) {
//                //                [dicTionary removeObjectForKey:key];
//            }
//            [mutableString appendFormat:@"%@", [NSString stringWithFormat:@"&%@=%@",key,dicTionary[key]]];
//        }
//    }
//    URLLog(@"%@",mutableString);
//}

+(NSMutableString *)logLoadRequestUrl:(NSString *)uuSTRing withpara:(NSMutableDictionary *)dic{
    NSMutableString *mutableString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@?",uuSTRing]];
    for (NSString *key in dic.allKeys) {
        if ([dic[key] isKindOfClass:[NSString class]]) {
            NSString *value = dic[key];
            if (value.length<1||value == nil) {
                [dic removeObjectForKey:key];
            }
        }
        [mutableString appendFormat:@"%@",[NSString stringWithFormat:@"%@=%@&",key,dic[key]]];
    }
    URLLog(@"%@",mutableString);
    return mutableString;
}


//处理回车单引号引起的错误
+(NSDictionary *)getDicFromData:(NSData *)d1{
    //处理掉回车、单引号引起的格式出错
    NSString *str = [[NSString alloc]initWithData:d1 encoding:NSUTF8StringEncoding];
    NSString *str1 = [[[str stringByReplacingOccurrencesOfString:@"\n" withString:@"%0A"]stringByReplacingOccurrencesOfString:@"\r" withString:@"%0D"] stringByReplacingOccurrencesOfString:@"\t" withString:@"%09"];
    NSData *d = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    
   
    NSDictionary *dic = [[NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingMutableContainers error:nil] mutableCopy];
    
    dic = [self dealObjectWithObj:dic];
    return dic;
}
/**
 *  递归调用
 *
 *  @param obj 要处理的对象
 *
 *  @return 处理过后的值
 */
+(id)dealObjectWithObj:(id)obj{
    if ([obj isKindOfClass:[NSArray class]]) {
        NSMutableArray *arr = [NSMutableArray new];
        for (id d in (NSArray *)obj) {
            [arr addObject:[self dealObjectWithObj:d]];
        }
        return arr;
    }else if ([obj isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *dic = [NSMutableDictionary new];
        for (NSString *s in ((NSDictionary *)obj).allKeys) {
            dic[s] = [self dealObjectWithObj:obj[s]];
        }
        return dic;
    }else{
        NSString *str = obj;
        if ([str isKindOfClass:[NSString class]]) {
            str = [[[str stringByReplacingOccurrencesOfString:@"%0A" withString:@"\n"]stringByReplacingOccurrencesOfString:@"%0D" withString:@"\r"] stringByReplacingOccurrencesOfString:@"%09" withString:@"\t"] ;
        }
        return str;
    }
}
@end
