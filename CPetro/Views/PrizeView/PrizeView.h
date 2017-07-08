//
//  PrizeView.h
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/27.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "CGView.h"

@protocol PrizeViewDelegate <NSObject>

-(void)viewRemove;//视图移除

@end

@interface PrizeView : CGView
-(id)initItemWithFram:(CGRect)frame andData:(NSArray *)paramData;

@property (nonatomic)id<PrizeViewDelegate>delegate;

@property (nonatomic,strong) UIButton *backViewBtn;
@property (nonatomic,strong) UIImageView *backImageView;//背景
@property (nonatomic,strong) UIImageView *tipImageView;//提示图片
@property (nonatomic,strong) UILabel *tipName;//中奖者人
@property (nonatomic,strong) UILabel *tipInfo;//中奖信息
@property (nonatomic,strong) UIButton    *Actionbtn;
@end
