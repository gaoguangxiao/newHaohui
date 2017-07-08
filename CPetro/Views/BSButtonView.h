//
//  BSButtonView.h
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "CGView.h"

@class BSButtonView;
@protocol BSButtonViewDelegate <NSObject>

@optional;
-(void)didActionBottomIndex:(NSInteger)index;

-(void)didActionBsbuttonview:(BSButtonView *)buttonView andINdex:(NSInteger )index;
@end

@interface BSButtonView : CGView
-(id)initItemWithFram:(CGRect)frame andData:(NSArray *)paramData;

//引入代理
@property(nonatomic)id<BSButtonViewDelegate>delegate;

@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;

-(void)updataUserStatus;
@end
