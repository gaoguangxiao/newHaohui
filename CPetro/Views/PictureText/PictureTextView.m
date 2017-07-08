//
//  PictureTextView.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/25.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "PictureTextView.h"


@implementation PictureTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pictureBtn];
        
        [self.pictureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
    }
    return self;
}


-(UIButton *)pictureBtn{
    if (!_pictureBtn) {
        _pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pictureBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_pictureBtn addTarget:self action:@selector(upinsideButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pictureBtn;
}
-(void)upinsideButton:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didActionBtnItem:)]) {
        [self.delegate didActionBtnItem:sender.tag];
    }
}
@end
