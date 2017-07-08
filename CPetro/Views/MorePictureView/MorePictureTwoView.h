//
//  MorePictureTwoView.h
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/25.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "CGView.h"

#import "PictureTextView.h"

@protocol MorePictureTwoViewDelegate <NSObject>

-(void)didMorePictureTwoViewBtnItem:(NSInteger)tagBtn;

@end

@interface MorePictureTwoView : CGView<PictureTextViewDelegate>


-(id)initItemWithFram:(CGRect)frame andData:(NSArray *)paramData andRow:(NSInteger)rowIndex;
@property(nonatomic)id<MorePictureTwoViewDelegate>delegate;


@property(nonatomic,strong)PictureTextView *leftPictureView;

@property(nonatomic,strong)PictureTextView *rightPictureView;

@end
