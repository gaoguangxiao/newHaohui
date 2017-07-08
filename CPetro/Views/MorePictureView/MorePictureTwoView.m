//
//  MorePictureTwoView.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/25.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "MorePictureTwoView.h"

@implementation MorePictureTwoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initItemWithFram:(CGRect)frame andData:(NSArray *)paramData andRow:(NSInteger)rowIndex;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftPictureView];
        [self addSubview:self.rightPictureView];
        
        int padding1 = 20;
        //
        [self.leftPictureView.pictureBtn setImage:[paramData firstObject] forState:0];
        self.leftPictureView.pictureBtn.tag = + rowIndex + 0 ;
        [self.leftPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).with.offset(padding1);
            make.right.equalTo(self.rightPictureView.mas_left).with.offset(-padding1);
            make.height.mas_equalTo(self.mas_height);
            make.width.equalTo(self.rightPictureView);
        }];
        
        
        [self.rightPictureView.pictureBtn setImage:[paramData lastObject] forState:UIControlStateNormal];
        self.rightPictureView.pictureBtn.tag = 1 + rowIndex;
        [self.rightPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self.leftPictureView.mas_right).with.offset(padding1);
            make.right.equalTo(self.mas_right).with.offset(-padding1);
            make.height.mas_equalTo(self.mas_height);
            make.width.equalTo(self.leftPictureView);
        }];

        
    }
    return self;
}

-(PictureTextView *)leftPictureView{
    if (!_leftPictureView) {
        _leftPictureView = [PictureTextView new];
        _leftPictureView.delegate = self;
    }
    return _leftPictureView;
}
-(PictureTextView *)rightPictureView{
    if (!_rightPictureView) {
        _rightPictureView = [PictureTextView new];
        _rightPictureView.delegate = self;
    }
    return _rightPictureView;
}
-(void)didActionBtnItem:(NSInteger)tagBtn{
    if ([self.delegate respondsToSelector:@selector(didMorePictureTwoViewBtnItem:)]) {
        [self.delegate didMorePictureTwoViewBtnItem:tagBtn];
    }
}
@end
