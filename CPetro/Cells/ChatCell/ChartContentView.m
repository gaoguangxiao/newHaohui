//
//  ChartContentView.m
//  气泡
//
//  Created by zzy on 14-5-13.
//  Copyright (c) 2014年 zzy. All rights reserved.
//
#define kContentStartMargin 25
#import "ChartContentView.h"
#import "ChartMessage.h"
@implementation ChartContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backImageView=[[UIImageView alloc]init];
        self.backImageView.userInteractionEnabled=YES;
        [self addSubview:self.backImageView];
        
        self.userName =[[UILabel alloc]init];
        self.userName.textColor = K_SubmitTitleColor;
        self.userName.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:self.userName];
        
        
        self.timterShow=[[UILabel alloc]init];
        self.timterShow.font = [UIFont systemFontOfSize:13.0f];
        self.timterShow.textColor = K_SubmitTitleColor;
        [self addSubview:self.timterShow];
        
        
        self.contentLabel=[[UILabel alloc]init];
        self.contentLabel.numberOfLines=0;
        self.contentLabel.textAlignment=NSTextAlignmentLeft;
        self.contentLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:15];
        [self addSubview:self.contentLabel];
        
        [self addGestureRecognizer: [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)]];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPress:)]];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.backImageView.frame=self.bounds;
    CGFloat contentLabelX=0;
    CGFloat userNameX;
    if([self.chartMessage.messageType intValue]==2){
        contentLabelX=kContentStartMargin*0.8;
        userNameX    = contentLabelX;
        self.userName.textAlignment = NSTextAlignmentLeft;
    }else if([self.chartMessage.messageType intValue]==1){
        contentLabelX=kContentStartMargin*0.5;
        userNameX    = contentLabelX;
        self.userName.textAlignment = NSTextAlignmentRight;
        
    }
    self.contentLabel.textAlignment = self.userName.textAlignment;
    self.timterShow.textAlignment  =self.userName.textAlignment;
    self.userName.frame = CGRectMake(userNameX, 0, self.frame.size.width-kContentStartMargin-5, 15);
    
    self.contentLabel.frame=CGRectMake(contentLabelX, 16, self.frame.size.width-kContentStartMargin-5, self.frame.size.height - 18);//33的高度
    
    self.timterShow.frame  =CGRectMake(contentLabelX, self.frame.size.height - 18, self.frame.size.width-kContentStartMargin-5, 15);
    
}
-(void)longTap:(UILongPressGestureRecognizer *)longTap
{
    if([self.delegate respondsToSelector:@selector(chartContentViewLongPress:content:)]){
        
        [self.delegate chartContentViewLongPress:self content:self.contentLabel.text];
    }
}
-(void)tapPress:(UILongPressGestureRecognizer *)tapPress
{
    if([self.delegate respondsToSelector:@selector(chartContentViewTapPress:content:)]){
        
        [self.delegate chartContentViewTapPress:self content:self.contentLabel.text];
    }
}
@end
