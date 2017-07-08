//
//  OnceTitleCell.m
//  SimpleSrore
//
//  Created by ggx on 2017/3/17.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "OnceTitleCell.h"

@implementation OnceTitleCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self.backgroundColor = [UIColor clearColor];
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.titleText];
        [self.titleText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@13);
            make.centerY.equalTo(self.contentView);
        }];
        
        //前进按钮
//        [self.contentView addSubview:self.imageQianjin];
//        [self.imageQianjin mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@-8);
//            make.height.equalTo(@20);
//            make.width.equalTo(@20);
//            make.centerY.equalTo(self.contentView);
//        }];
        
    }
    
    return self;
    
}
#pragma mark - 懒加载
-(UILabel *)titleText{
    if (!_titleText) {
        _titleText = [[UILabel alloc]init];
    }
//    _titleText.textColor = K_NavigationTitleColor;
    _titleText.font      = [UIFont systemFontOfSize:14.0];
    _titleText.textAlignment = NSTextAlignmentCenter;
    return _titleText;
}
-(UIImageView *)imageQianjin{
    if (!_imageQianjin) {
        _imageQianjin = [[UIImageView alloc]init];
    }
    _imageQianjin.image = [UIImage imageNamed:@"UserCenterQianjin"];
    _imageQianjin.contentMode = UIViewContentModeScaleAspectFit;
    return _imageQianjin;
}

-(void)setData:(id)data{
    self.titleText.text = [NSString stringWithFormat:@"%@",data];
}

@end
