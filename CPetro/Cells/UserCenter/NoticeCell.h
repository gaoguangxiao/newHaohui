//
//  NoticeCell.h
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/5.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "CGTableViewCell.h"

@class EntityAd;
@interface NoticeCell : CGTableViewCell
{
    __weak IBOutlet UILabel *_day;
    __weak IBOutlet UILabel *_timer;
    __weak IBOutlet UILabel *_content;
    
}
@property(nonatomic,strong)EntityAd *add;
@end
