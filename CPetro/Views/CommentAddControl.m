//
//  CommentAddControl.m
//  hongbao
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 wang shuguan. All rights reserved.
//

#import "CommentAddControl.h"

@implementation CommentAddControl
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self Init];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self Init];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self Init];
    }
    return self;
}
-(void)Init{
    
    UIImage *img = [UIImage imageNamed:@"popo"];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-img.size.width-5, 0, img.size.width, img.size.height)];
    imgView.image = img;
    [self addSubview:imgView];
    
    
    
    UIButton *bt1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-img.size.width-5, 8, img.size.width, (img.size.height-8)/4.0f)];
    [bt1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [bt1 setTitle:@"  最新优惠" forState:0];
    [bt1 setTitleColor:K_NavigationTitleColor forState:UIControlStateNormal];
    bt1.titleLabel.font = [UIFont systemFontOfSize:18];
    [bt1 setContentEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [self addSubview:bt1];
    bt1.tag = 0;
    [bt1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *bt2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-img.size.width-5,CGRectGetMaxY(bt1.frame), img.size.width-5, bt1.frame.size.height-5)];
    [bt2 setTitle:@"  活动大厅" forState:0];
    bt2.titleLabel.font = [UIFont systemFontOfSize:18];
    [bt2 setTitleColor:K_NavigationTitleColor forState:UIControlStateNormal];
    [bt2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [bt2 setContentEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [self addSubview:bt2];
    bt2.tag = 1;
    [bt2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bt3 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-img.size.width-5,CGRectGetMaxY(bt2.frame), img.size.width-5, bt2.frame.size.height-5)];
    [bt3 setTitle:@"  线路检测" forState:0];
    bt3.titleLabel.font = [UIFont systemFontOfSize:18];
    [bt3 setTitleColor:K_NavigationTitleColor forState:UIControlStateNormal];
    [bt3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [bt3 setContentEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [self addSubview:bt3];
    bt3.tag = 2;
    [bt3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *bt4 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-img.size.width-5, CGRectGetMaxY(bt3.frame), img.size.width-5, bt1.frame.size.height-5)];
    [bt4 setTitle:@"  联系我们" forState:0];
    bt4.titleLabel.font = [UIFont systemFontOfSize:18];
    [bt4 setTitleColor:K_NavigationTitleColor forState:UIControlStateNormal];
    [bt4 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [bt4 setContentEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [self addSubview:bt4];
    bt4.tag = 3;
    [bt4 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.tag = -1;
}
-(void)click:(UIControl *)sender{
    if (self.clickAction) {
        self.clickAction(sender.tag);
        [self removeFromSuperview];
    }
}
@end
