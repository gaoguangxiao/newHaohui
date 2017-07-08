
//
//  Config.h
//  CPetro
//
//  Created by ggx on 2017/3/8.
//  Copyright © 2017年 高广校. All rights reserved.
//  应用配置

#ifndef Config_h
#define Config_h
//http://


//http://127.0.0.1:8888/api/member/bind
//#define HOSTDOMAIN @"42.51.10.86:8087"
//#define WEBSEARVICE  [NSString stringWithFormat:@"http://%@/MethodIn.asmx",HOSTDOMAIN]

//http://103.226.152.162:7777/
#define HOSTDOMAIN @"103.226.152.162:7777"
#define WEBSEARVICE  [NSString stringWithFormat:@"http://%@/",HOSTDOMAIN]

//设置Webservice变量结构
#define API_STATUS @"code"
#define API_CONTENT @"result"
#define API_MODEL @"model_list"
#define API_MSG @"errorMsg"

#endif /* Config_h */
