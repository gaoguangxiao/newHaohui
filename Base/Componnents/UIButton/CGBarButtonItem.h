//
//  CGBarButtonItem.h
//  hongbao
//
//  Created by 高广校 on 15/12/25.
//  Copyright © 2015年 gao guangxiao. All rights reserved.
//

#import "CGButton.h"

@interface CGBarButtonItem : CGButton
//创建文字按钮
+ (instancetype)buttonWithTitle:(NSString *)buttonTitle contentHorizontalAlignment:(UIControlContentHorizontalAlignment)alignment;

//创建图标按钮
+ (instancetype)buttonWithImageNormal:(UIImage *)imageNormal imageSelected:(UIImage *)imageSelected;

//创建文字加图片按钮
+ (instancetype)buttonWithTitle:(NSString *)buttonTitle imageNormal:(UIImage *)imageNormal;
@end
