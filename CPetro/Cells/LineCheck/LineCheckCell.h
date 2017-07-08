//
//  LineCheckCell.h
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/2.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "CGTableViewCell.h"

#import "EntityLineCheck.h"
@interface LineCheckCell : CGTableViewCell
{
    __weak IBOutlet UITextField *_lineUrl;
    __weak IBOutlet UIButton *_lineSms;
    
}
@property(nonatomic,strong)EntityLineCheck *lineCheck;
@end
