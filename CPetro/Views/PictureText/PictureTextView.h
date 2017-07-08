//
//  PictureTextView.h
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/25.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "CGView.h"
#import <Masonry.h>

@protocol PictureTextViewDelegate <NSObject>

-(void)didActionBtnItem:(NSInteger)tagBtn;

@end

@interface PictureTextView : CGView

@property(nonatomic,strong)UIButton *pictureBtn;

@property(nonatomic)id<PictureTextViewDelegate>delegate;
@end
