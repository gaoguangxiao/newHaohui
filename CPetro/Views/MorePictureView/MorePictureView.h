//
//  MorePictureView.h
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/25.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "CGView.h"

#import "MorePictureTwoView.h"

@class EntityAd;
@protocol MorePictureViewDelegate <NSObject>

-(void)clickedByHomeAtIndex:(NSInteger)index data:(EntityAd *)data;

-(void)didMorePictureViewBtn:(NSInteger)tagBtn;

@end

@interface MorePictureView : CGView<MorePictureTwoViewDelegate>
{
    dispatch_source_t timer;
}
-(id)initMorePictureItemWithFram:(CGRect)frame andData:(NSArray *)paramData;

@property(nonatomic,strong)NSArray *dataNotice;

@property(nonatomic)id<MorePictureViewDelegate>delegate;

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *bgimageView;

@end
