//
//  ChartMessage.h
//  tulingIOS
//
//  Created by Colin on 14-8-9.
//  Copyright (c) 2014年 icephone. All rights reserved.
//


#import "EntityObject.h"

@interface ChartMessage : EntityObject

@property (nonatomic, copy) NSString *messageType;
@property (nonatomic, copy) NSString *memberName;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *content;
//@property (nonatomic, copy) NSDictionary *dict;
@end
