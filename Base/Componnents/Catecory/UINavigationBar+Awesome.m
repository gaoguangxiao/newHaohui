//
//  UINavigationBar+Awesome.m
//  CPetro
//
//  Created by ggx on 2017/3/10.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>
@implementation UINavigationBar (Awesome)

static char overlayKey;
- (UIView *)overlay{
    return objc_getAssociatedObject(self, &overlayKey);
}
- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
     self.overlay.backgroundColor = backgroundColor;
}

- (void)lt_setTitleColor:(UIColor *)titleColor{
    
    self.tintColor = titleColor;//
    //导航字体
    [self setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:titleColor}];
}
- (void)lt_setbarStyle:(UIBarStyle)barStyle{
    [self setBarStyle:barStyle];
}
@end
