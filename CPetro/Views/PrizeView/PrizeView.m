//
//  PrizeView.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/27.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "PrizeView.h"

#import <Masonry.h>
@implementation PrizeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initItemWithFram:(CGRect)frame andData:(NSArray *)paramData{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backView];
        [self addSubview:self.backImageView];
        
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.centerY.equalTo(self);
            make.height.equalTo(@200);
        }];
        
        [self.backImageView addSubview:self.tipImageView];
        [self.backImageView addSubview:self.tipName];
        [self.backImageView addSubview:self.tipInfo];
        [self.backImageView addSubview:self.Actionbtn];
        
        [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(@20);
            make.height.equalTo(@50);
        }];
        if ([[paramData firstObject]isKindOfClass:[UIImage class]]) {
            self.tipImageView.image = [paramData firstObject];
        }
        
        if ([[paramData lastObject]isEqualToString:@"差一点就中奖啦~"]) {
            [self.tipName mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.tipImageView);
                make.top.equalTo(self.tipImageView.mas_bottom).offset(25);
            }];
            if ([[paramData lastObject]isKindOfClass:[NSString class]]) {
                self.tipName.text = [paramData lastObject];
                self.tipName.hidden = NO;
            }

        }else{
            [self.tipName mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.tipImageView);
                make.top.equalTo(self.tipImageView.mas_bottom).offset(15);
                make.height.equalTo(@20);
            }];
            
            [self.tipInfo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.tipImageView);
                make.top.equalTo(self.tipName.mas_bottom).offset(5);
                
            }];
            if ([[paramData lastObject]isKindOfClass:[NSString class]]) {
                self.tipInfo.text = [paramData lastObject];
                self.tipName.hidden = NO;
            }

        }
        
        
        
        [self.Actionbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-10);
            make.height.equalTo(@40);
            make.centerX.equalTo(self);
            make.width.equalTo(@150);
        }];
    }
    
    return self;
}

-(UIButton *)backView{
    if (!_backViewBtn) {
        _backViewBtn = [UIButton new];
        _backViewBtn.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
//        [_backViewBtn addTarget:self action:@selector(didACtionBackView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backViewBtn;
}
-(UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.image = [UIImage imageNamed:@"EggResultBackImage"];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}
-(UIImageView *)tipImageView{
    if (!_tipImageView) {
        _tipImageView = [UIImageView new];
        _tipImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _tipImageView;
}
-(UILabel *)tipName{
    if (!_tipName) {
        _tipName = [UILabel new];
        _tipName.text = @"恭喜您获得";
        _tipName.font = [UIFont systemFontOfSize:20.0f];
        _tipName.textColor = K_NavigationTitleColor;
        _tipName.hidden = YES;
    }
    return _tipName;
}
-(UILabel *)tipInfo{
    if (!_tipInfo) {
        _tipInfo = [UILabel new];
        _tipInfo.textColor = [UIColor yellowColor];
        _tipInfo.font = [UIFont systemFontOfSize:25.0f];
    }
    return _tipInfo;
}
-(UIButton *)Actionbtn{
    if (!_Actionbtn) {
        _Actionbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Actionbtn setImage:[UIImage imageNamed:@"EggResultBtn"] forState:0];
        [_Actionbtn addTarget:self action:@selector(didACtionBackView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Actionbtn;
}
-(void)didACtionBackView{
    if ([self.delegate respondsToSelector:@selector(viewRemove)]) {
        [self.delegate viewRemove];
    }
    [self removeFromSuperview];
}
@end
