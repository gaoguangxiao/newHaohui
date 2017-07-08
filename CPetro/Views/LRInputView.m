//
//  LRInputView.m
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "LRInputView.h"

#import <Masonry.h>
@implementation LRInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initItemWithFrame:(CGRect)frame andlabelName:(NSDictionary *)paramData{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.tipName];
        [self.tipName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@70);
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(@-5);
            make.width.equalTo(@80);//
        }];
        
        if ([paramData valueForKey:@"assistantName"]) {
            [self.tipName setTitle:paramData[@"assistantName"] forState:0];
            if ([self.tipName.currentTitle isEqualToString:@"账户"]) {
                [self.tipName setImage:[UIImage imageNamed:@"UserCeterAccount"] forState:0];
            }else if ([self.tipName.currentTitle isEqualToString:@"积分"]){
                [self.tipName setImage:[UIImage imageNamed:@"UserCeterLevel"] forState:0];
            }else{
                [self.tipName setImage:[UIImage imageNamed:@"UserCeterScore"] forState:0];

            }
        }
        
        [self addSubview:self.inputLineView];
        [self.inputLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(@1);
            make.bottom.top.equalTo(self.tipName);
        }];
        
        [self addSubview:self.inputText];
        self.inputText.userInteractionEnabled = NO;
        [self.inputText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(self.inputLineView.mas_right).offset(40);//dui'zhe
            make.right.equalTo(self).offset(-8);
            make.bottomMargin.equalTo(@-5);
            make.top.equalTo(self).offset(5);
        }];
        if ([paramData valueForKey:@"assistantAccount"]) {
            self.inputText.text = paramData[@"assistantAccount"];
        }else if ([paramData valueForKey:@"assistantPlaceHolder"]){
            NSString *placeString = paramData[@"assistantPlaceHolder"];
            NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeString];
            [placeholder addAttribute:NSForegroundColorAttributeName
                                value:K_SubmitTitleColor
                                range:NSMakeRange(0, placeString.length)];
            _inputText.attributedPlaceholder = placeholder;
        }else{
            self.inputText.placeholder = @"设置登陆密码";
        }
    }
    return self;
}
- (id)initTextWithFrame:(CGRect)frame andlabelName:(NSString *)paramData{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backImageView];
//        self.backImageView
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(self).offset(15);//dui'zhe
            make.right.equalTo(self).offset(-15);
            make.bottomMargin.equalTo(@-5);
            make.top.equalTo(self).offset(5);
        }];

        
        [self addSubview:self.inputText];
        self.inputText.backgroundColor = [UIColor clearColor];//透明颜色
        [self.inputText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(self).offset(15);//dui'zhe
            make.right.equalTo(self).offset(-15);
            make.bottomMargin.equalTo(@-5);
            make.top.equalTo(self).offset(5);
        }];

        NSString *placeString = paramData;
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeString];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:[UIColor whiteColor]
                            range:NSMakeRange(0, placeString.length)];
        self.inputText.textAlignment = NSTextAlignmentCenter;
        self.inputText.attributedPlaceholder = placeholder;

    }
    return self;
}
-(UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.image = [UIImage imageNamed:@"UserBandInput"];
    }
    return _backImageView;
}
-(UIButton *)tipName{
    if (!_tipName) {
        _tipName = [[UIButton alloc]init];
    }
    _tipName.titleLabel.font      = [UIFont systemFontOfSize:15.0];
    return _tipName;
}
-(UITextField *)inputText{
    if (!_inputText) {
        _inputText = [[UITextField alloc]init];
    }
    _inputText.textColor = K_NavigationTitleColor;
    _inputText.font      = [UIFont systemFontOfSize:18.0];
    return _inputText;
}
-(UIView *)inputLineView{
    if (!_inputLineView) {
        _inputLineView = [[UIView alloc]init];
    }
    _inputLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return _inputLineView;
}
@end
