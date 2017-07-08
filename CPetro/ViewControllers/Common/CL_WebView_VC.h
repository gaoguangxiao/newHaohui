//
//  CL_WebView_VC.h
//  HyJoinCar
//
//  Created by ggx on 2016/12/9.
//  Copyright © 2016年 乐途拼车. All rights reserved.
//

#import "ViewControllerImpl.h"

@class EntityUrl;
@interface CL_WebView_VC : ViewControllerImpl
@property(nonatomic,copy)NSString *navigationTitle;
@property(nonatomic,strong)NSURL *url;
@property(nonatomic,strong)NSArray *urlData;
@end
