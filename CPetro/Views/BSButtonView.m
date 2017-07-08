//
//  BSButtonView.m
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "BSButtonView.h"

#import <Masonry.h>
@implementation BSButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initItemWithFram:(CGRect)frame andData:(NSArray *)paramData{
    if (self = [super initWithFrame:frame]) {
        
        int padding1 = 20;
        if (paramData.count == 1) {
            [self addSubview:self.leftBtn];
            [self.leftBtn setImage:[paramData firstObject] forState:UIControlStateNormal];
            [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).with.offset(padding1);
                make.right.equalTo(self.mas_right).with.offset(-padding1);
                make.height.mas_equalTo(self.mas_height);
            }];
        }
        
        if (paramData.count == 2) {
            [self addSubview:self.leftBtn];
            [self addSubview:self.rightBtn];
            
            
            [self.leftBtn setTitle:[paramData firstObject] forState:UIControlStateNormal];
            [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).with.offset(padding1);
                make.right.equalTo(self.rightBtn.mas_left).with.offset(-padding1);
                make.height.mas_equalTo(@40);
                make.width.equalTo(self.rightBtn);
            }];
            
            
            [self.rightBtn setTitle:[paramData lastObject] forState:UIControlStateNormal];
            [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.mas_centerY);
                make.left.equalTo(self.leftBtn.mas_right).with.offset(padding1);
                make.right.equalTo(self.mas_right).with.offset(-padding1);
                make.height.mas_equalTo(@40);
                make.width.equalTo(self.leftBtn);
            }];
        }
       
        
        
    }
    return self;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.imageView.contentMode = UIViewContentModeScaleToFill;
//        [_leftBtn setTitleColor:K_NavigationTitleColor forState:0];
//        [_leftBtn setBackgroundColor:K_NavigationBackColor];
//        _leftBtn.layer.cornerRadius = 2;
//        _leftBtn.titleLabel.font    = K_SystemFont;
        _leftBtn.tag = 0;
        [_leftBtn addTarget:self action:@selector(upinsideButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.tag = 1;
        [_rightBtn setTitleColor:K_NavigationTitleColor forState:0];
        [_rightBtn setBackgroundColor:K_NaMustBanColor];
        _rightBtn.layer.cornerRadius = 2;
        [_rightBtn addTarget:self action:@selector(upinsideButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
-(void)upinsideButton:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didActionBottomIndex:)]) {
        [self.delegate didActionBottomIndex:sender.tag];
    }
    if ([self.delegate respondsToSelector:@selector(didActionBsbuttonview:andINdex:)]) {
        [self.delegate didActionBsbuttonview:self andINdex:sender.tag];
    }
}
-(void)updataUserStatus{
    //修改店员的状态
    
}
@end
