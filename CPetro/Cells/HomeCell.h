//
//  HomeCell.h
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "CGTableViewCell.h"

#import "HomeOrderEntity.h"

//引入店员
#import "EntityAssistant.h"
@interface HomeCell : CGTableViewCell
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UILabel *orderId;
@property(nonatomic,strong)UILabel *orderTime;
@property(nonatomic,strong)HomeOrderEntity *homeOrderEntity;

@property(nonatomic,strong)EntityAssistant *entityAssistant;
@end
