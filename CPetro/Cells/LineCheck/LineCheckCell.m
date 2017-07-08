//
//  LineCheckCell.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/2.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "LineCheckCell.h"

@implementation LineCheckCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setLineCheck:(EntityLineCheck *)lineCheck{
    
    _lineUrl.text = lineCheck.url;
    
    [_lineSms setTitle:[self smsTitme] forState:0];
}
-(NSString *)smsTitme{
    return [NSString stringWithFormat:@"%dms",20+arc4random()%50];
}
@end

