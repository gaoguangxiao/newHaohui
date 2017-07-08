//
//  NoticeCell.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/5.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "NoticeCell.h"

#import "EntityAd.h"
@implementation NoticeCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.data) {
            }
}
-(void)setAdd:(EntityAd *)add{
    EntityAd *cell = add;
    
    NSDateFormatter *dayStr = [NSDateFormatter dateFormatterWithFormat:@"dd"];
    NSString *dayTime = [dayStr stringFromDate:[U_SERVER_FORMATTER dateFromString:cell.createTime]];
    _day.text = dayTime;
    
    NSDateFormatter *yearStr = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM"];
    NSString *yearTime = [yearStr stringFromDate:[U_SERVER_FORMATTER dateFromString:cell.createTime]];
    _timer.text = yearTime;
    
    _content.text = cell.zhaiyao;

}
@end
