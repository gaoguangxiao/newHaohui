//
//  MyAssistantCell.m
//  SimpleSrore
//
//  Created by ggx on 2017/3/17.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "MyAssistantCell.h"


@implementation MyAssistantCell

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.titleText];
        [self.titleText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@13);
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.contentView addSubview:self.assistantStatus];
        [self.assistantStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(@-13);
            make.height.equalTo(@25);
            make.width.equalTo(@70);
            make.centerY.equalTo(self.contentView);
        }];
        self.assistantStatus.layer.cornerRadius = 3;//设置圆角
    }
    return self;
}
-(UILabel *)titleText{
    if (!_titleText) {
        _titleText = [[UILabel alloc]init];
    }
    _titleText.textColor = K_SubmitTitleColor;
    _titleText.font      = K_SystemFontFourteen;
    return _titleText;
}
-(UIButton *)assistantStatus{
    if (!_assistantStatus) {
        _assistantStatus = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    _assistantStatus.userInteractionEnabled = NO;//设置
    [_assistantStatus setTitleColor:K_NavigationTitleColor forState:0];
    _assistantStatus.titleLabel.font = K_SystemFontFourteen;
    return _assistantStatus;
}

-(void)setAssistantData:(EntityAssistant *)assistantData{
    
    _assistantData = assistantData;
    _titleText.text = [NSString stringWithFormat:@"%@",assistantData.assistantName];
    
    if ([assistantData.assistantStatus isEqualToString:@"1"]) {
        [_assistantStatus setTitle:@"正常" forState:0];
        [_assistantStatus setBackgroundColor:K_NavigationBackColor];
    }else{
        [_assistantStatus setTitle:@"已禁用" forState:0];
        [_assistantStatus setBackgroundColor:K_NaMustBanColor];
    }
}
@end
