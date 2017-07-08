//
//  CGTableViewCell.h
//  HyJoinCar
//
//  Created by ggx on 2016/10/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry.h>
//#import "UserInfo.h"
//#import "DataModel.h"
@interface CGTableViewCell : UITableViewCell


@property(nonatomic,strong)UIView *lineView;

-(void)Init;
/**
 所有的cell全部继承这个cell，传值采用 data
 */
@property(nonatomic,strong)id data;

@property(nonatomic,strong)NSIndexPath *indexPath;
@end
