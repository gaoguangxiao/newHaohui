//
//  CGBarButtonItem.m
//  hongbao
//
//  Created by 高广校 on 15/12/25.
//  Copyright © 2015年 gao guangxiao. All rights reserved.
//

#import "CGBarButtonItem.h"

@implementation CGBarButtonItem
//实现创建文字按钮
+ (instancetype)buttonWithTitle:(NSString *)buttonTitle contentHorizontalAlignment:(UIControlContentHorizontalAlignment)alignment{
    //初始化
    CGBarButtonItem *barButtonItem = [super buttonWithType:UIButtonTypeSystem];
    
    //动态计算按钮宽度
    CGSize buttonSize = [buttonTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f]}];
    //限制按钮的最大宽度为（中文4个字的宽度：68）
    if (buttonSize.width > 68) {
        buttonSize.width = 68;
    }
    
    //按钮文字过长截断方式
    barButtonItem.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    barButtonItem.bounds = CGRectMake(0, 0, buttonSize.width, 33);
    barButtonItem.contentHorizontalAlignment = alignment;//
    [barButtonItem setTitle:buttonTitle forState:UIControlStateNormal];
    //按钮字体颜色默认为白色
    barButtonItem.tintColor = [UIColor darkGrayColor];
    barButtonItem.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    
    return barButtonItem;
}

//实现创建图标按钮
+ (instancetype)buttonWithImageNormal:(UIImage *)imageNormal imageSelected:(UIImage *)imageSelected{
    CGBarButtonItem *barButtonItem = [super buttonWithType:UIButtonTypeCustom];
    
    barButtonItem.frame = CGRectMake(0, 0, 33, 33);
    [barButtonItem setImage:imageNormal forState:UIControlStateNormal];
    [barButtonItem setImage:imageSelected forState:UIControlStateHighlighted];
    
    return barButtonItem;
}
//
+(instancetype)buttonWithTitle:(NSString *)buttonTitle imageNormal:(UIImage *)imageNormal{
    CGBarButtonItem *barButtonItem = [super buttonWithType:UIButtonTypeSystem];
    
    //动态计算按钮宽度
    CGSize buttonSize = [buttonTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    //限制按钮的最大宽度为（中文4个字的宽度：68）
    if (buttonSize.width > 68) {
        buttonSize.width = 68;
    }
    
    UIImageView *i = [[UIImageView alloc]initWithImage:imageNormal];
    i.frame = CGRectMake(0.0f, 8.5, 17, 17);
    
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(i.frame)-2, 7, buttonSize.width, buttonSize.height)];
    l.text = buttonTitle;
    l.textColor = [UIColor whiteColor];
    l.backgroundColor = [UIColor clearColor];
    l.font = [UIFont systemFontOfSize:15.0f];
    [barButtonItem addSubview:i];
    [barButtonItem addSubview:l];
    
    
    //按钮文字过长截断方式
    barButtonItem.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    //最后按钮的 宽度加上图片的宽度
    barButtonItem.frame = CGRectMake(0, 0, buttonSize.width + CGRectGetWidth(i.frame), 33);
    
    //按钮字体颜色默认为白色
    
    return barButtonItem;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
