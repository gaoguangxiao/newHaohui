//
//  ViewControllerImpl.h
//  CPetro
//
//  Created by ggx on 2017/3/8.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Service.h"
#import "UIView+Toast.h"
#import "HUDHelper.h"

@interface ViewControllerImpl : UIViewController


@property(nonatomic,copy,readwrite)NSString *navigationItemTitle;
-(void)Init;

@property(nonatomic,strong)UIImageView *imageTitle;
@property(nonatomic,strong)UIImageView *backImageView;

@property(nonatomic,strong) NSArray*urlArray;

/**
 加载网络请求

 @param animated <#animated description#>
 @param title <#title description#>
 @param block <#block description#>
 @param completion <#completion description#>
 */
- (void)showAnimated:(BOOL)animated title:(NSString *)title whileExecutingBlock:(CGDataResult *(^)())block completionBlock:(void(^)(BOOL b,CGDataResult *r))completion;
@end
