//
//  CGTableViewCell.m
//  HyJoinCar
//
//  Created by ggx on 2016/10/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CGTableViewCell.h"

@implementation CGTableViewCell
-(void)Init{
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self Init];
        
        //父类加线
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@13);
            make.height.equalTo(@1);
            make.bottom.right.equalTo(@0);
        }];

    }
    return self;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
    }
    _lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return _lineView;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self Init];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
