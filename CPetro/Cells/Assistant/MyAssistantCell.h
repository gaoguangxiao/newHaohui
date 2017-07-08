//
//  MyAssistantCell.h
//  SimpleSrore
//
//  Created by ggx on 2017/3/17.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "CGTableViewCell.h"

#import "EntityAssistant.h"
@interface MyAssistantCell : CGTableViewCell
@property(nonatomic,strong)UILabel *titleText;
@property(nonatomic,strong)UIButton *assistantStatus;

@property(nonatomic,strong)EntityAssistant *assistantData;
@end
