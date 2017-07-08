//
//  ViewStyle.h
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-4.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewStyle : NSObject
-(void)applyBorderStyle:(UIView *)v;
-(void)applyClickedBorderStyle:(UIView *)v;
-(void)applyGroupBorderStyle:(UIView *)v;
-(void)applyTranspondBorderStyle:(UIView *)v;
+(void)applyOrangeBorderStyle:(UIView *)v;//设置边框
-(void)applyShadawStyle:(UIView *)v;
-(void)applyBorderNoRoundStyle:(UIView *)v;
+(void)applyRadius2Style:(UIView *)v;
+(void)applyRadius2StyleColor:(UIView *)v;
+(void)applyRadius5Style:(UIView *)v;
+(void)applyRadius20Style:(UIView *)v;
+(void)applyBorderStyleView:(UIView *)v;//余额
+(void)applyRadius5Style_colorRed:(UIView *)v;
+(void)applyRadius40Style:(UIView *)v;
+(void)applyRadius5BorderStyle:(UIView *)v;
+(void)applyRadius10Style:(UIView *)v;
@end
