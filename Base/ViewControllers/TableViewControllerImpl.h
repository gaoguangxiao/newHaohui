//
//  TableViewControllerImpl.h
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGTableView+loadView2.h"//
@interface TableViewControllerImpl : UITableViewController<UIView_LoadViewDelegate>

@property(nonatomic,copy,readwrite)NSString *navigationItemTitle;

@property(nonatomic,strong)NSMutableArray *baseData;
@end
