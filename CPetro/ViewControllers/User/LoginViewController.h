//
//  LoginViewController.h
//  CPetro
//
//  Created by ggx on 2017/3/8.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "ViewControllerImpl.h"

@interface LoginViewController : ViewControllerImpl

//账户绑定成功
@property(nonatomic,strong)void(^accountBandSuccess)();
@end
